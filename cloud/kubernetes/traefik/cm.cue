package traefik

import (
	"encoding/yaml"
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

#traefik_yml: {

}

traefik_yml: {
	log: level: "INFO"
	api: {
		dashboard: true
		insecure:  true
	}
	entryPoints: websecure: address: ":443"
	providers: kubernetesCRD: {}
	certificatesResolvers: letsencrypt: acme: {
		email:   "augustfengd@gmail.com"
		storage: "acme.json"
		tlsChallenge: {}
		caserver: "https://acme-v02.api.letsencrypt.org/directory"
	}
}

cm: kubernetes.#configmaps & {
	"traefik": "traefik.yml": yaml.Marshal(traefik_yml)
}