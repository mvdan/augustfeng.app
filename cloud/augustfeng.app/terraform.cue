package terraform

_configuration: lib.digitalocean & {
	resource: digitalocean_droplet: "k3s-agent-0": {}
	resource: digitalocean_droplet: "k3s-server": {}
}

configuration: lib.gcp & {
}
