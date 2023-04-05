#![feature(iter_intersperse, try_find)]

use futures::TryFutureExt;
pub mod kubernetes;
use kubernetes::{Deployment, Node, NodeAddress, ObjectList, Pod, ReplicaSet};

struct Program {
    client: reqwest::Client,
}

#[derive(Debug)]
enum Error {
    MissingAvailableReplicas,
    MissingPodFromReplicaSet,
    MissingExternalIP,
    MissingServiceAccountFile(std::io::Error),
    ClientConstructionError(reqwest::Error),
    ClientCertificateError(reqwest::Error),
    ClientHeaderError(reqwest::header::InvalidHeaderValue),
    SerializationError(serde_json::Error),
    RequestError(reqwest::Error),
}

impl Program {
    async fn new() -> Result<Program, Error> {
        Self::create_client().map(|client| Program { client })
    }


    async fn run(self) -> Result<(), Error> {
        let deployment = self.get_traefik_deployment("system-ingress", "traefik").await?;
        let replicaset = self.get_traefik_replicaset(deployment).await?;
        let pod = self.get_traefik_pod(replicaset).await?;
        let node = self.get_traefik_node(pod).await?;
        let ip = self.get_external_address(node).await?;
        self.configure_dns_record(ip).await
    }

    fn create_client() -> Result<reqwest::Client, Error> {
        let cert = std::fs::read("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
            .map_err(Error::MissingServiceAccountFile)
            .and_then(|bytes| {
                reqwest::Certificate::from_pem(&bytes).map_err(Error::ClientCertificateError)
            })?;

        let headers =
            std::fs::read_to_string("/var/run/secrets/kubernetes.io/serviceaccount/token")
                .map_err(Error::MissingServiceAccountFile)
                .and_then(|token| {
                    let mut headers = reqwest::header::HeaderMap::new();
                    headers.insert(
                        reqwest::header::AUTHORIZATION,
                        reqwest::header::HeaderValue::from_str(
                            format!("Bearer {}", token).as_str(),
                        )
                        .map_err(Error::ClientHeaderError)?,
                    );
                    Ok(headers)
                })?;

        reqwest::Client::builder()
            .add_root_certificate(cert)
            .default_headers(headers)
            .build()
            .map_err(Error::ClientConstructionError)
    }

    async fn serialize_response<T: serde::de::DeserializeOwned>(
        response: reqwest::Response,
    ) -> Result<T, Error> {
        response
            .bytes()
            .await
            .map_err(Error::RequestError)
            .and_then(|full| {
                println!("{:?}", full);
                serde_json::from_slice(&full).map_err(Error::SerializationError)
            })
    }

    async fn get_traefik_deployment(
        &self,
        namespace: &str,
        deployment: &str,
    ) -> Result<Deployment, Error> {
        let url = format!(
        "https://kubernetes.default.svc/apis/apps/v1/namespaces/{namespace}/deployments/{deployment}"
    );
        self.client
            .get(url)
            .send()
            .map_err(Error::RequestError)
            .and_then(Self::serialize_response)
            .await
    }

    async fn get_traefik_replicaset(&self, deployment: Deployment) -> Result<ReplicaSet, Error> {
        let namespace = deployment.metadata.namespace;
        let query = deployment
            .spec
            .selector
            .match_labels
            .iter()
            .map(|(label, value)| format!("{}%3D{}", label, value))
            .intersperse(String::from("&"))
            .collect::<String>();

        let url = format!(
        "https://kubernetes.default.svc/apis/apps/v1/namespaces/{}/replicasets?labelSelector={}",
        namespace, query
    );
        self.client
            .get(url)
            .send()
            .map_err(Error::RequestError)
            .and_then(Self::serialize_response::<ObjectList<ReplicaSet>>)
            .await
            .map(|object_list| object_list.items)
            .and_then(|replicasets| {
                replicasets
                    .into_iter()
                    .find(|rs| rs.spec.replicas == 1)
                    .ok_or(Error::MissingAvailableReplicas)
            })
    }

    async fn get_traefik_pod(&self, replicaset: ReplicaSet) -> Result<Pod, Error> {
        let namespace = replicaset.metadata.namespace;
        let query = replicaset
            .spec
            .selector
            .match_labels
            .iter()
            .map(|(label, value)| format!("{}%3D{}", label, value))
            .intersperse(String::from("&"))
            .collect::<String>();

        let url = format!(
            "https://kubernetes.default.svc/api/v1/namespaces/{}/pods?labelSelector={}",
            namespace, query
        );

        self.client
            .get(url)
            .send()
            .map_err(Error::RequestError)
            .and_then(Self::serialize_response::<ObjectList<Pod>>)
            .await
            .map(|object_list| object_list.items)
            .and_then(|pods| {
                pods.into_iter()
                    .next()
                    .ok_or(Error::MissingPodFromReplicaSet)
            })
    }

    async fn get_traefik_node(&self, pod: Pod) -> Result<Node, Error> {
        let url = format!(
            "https://kubernetes.default.svc/api/v1/nodes/{}",
            pod.spec.node_name
        );

        self.client
            .get(url)
            .send()
            .map_err(Error::RequestError)
            .and_then(Self::serialize_response::<Node>)
            .await
    }

    async fn get_external_address(&self, node: Node) -> Result<NodeAddress, Error> {
        node.status
            .addresses
            .into_iter()
            .find(|node_address| node_address.type_ == "ExternalIP")
            .ok_or(Error::MissingExternalIP)
    }

    async fn configure_dns_record(&self, node_address: NodeAddress) -> Result<(), Error> {
        let client = reqwest::Client::new();
        client.patch("https://dns.googleapis.com/dns/v1beta2/projects/augustfengd/managedZones/augustfeng/rrsets/augustfeng.app./A").send().await;

        Ok(println!(
            "configuring dns record to : {}",
            node_address.address
        ))
    }
}

#[tokio::main]
async fn main() {
    match Program::new().and_then(Program::run).await {
        Ok(v) => println!("{:?}", v),
        Err(e) => eprintln!("{:?}", e),
    }
}