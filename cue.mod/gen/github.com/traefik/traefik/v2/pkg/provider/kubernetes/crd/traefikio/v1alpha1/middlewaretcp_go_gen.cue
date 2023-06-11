// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefikio/v1alpha1

package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/traefik/traefik/v2/pkg/config/dynamic"
)

// MiddlewareTCP is the CRD implementation of a Traefik TCP middleware.
// More info: https://doc.traefik.io/traefik/v2.10/middlewares/overview/
#MiddlewareTCP: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	metadata: metav1.#ObjectMeta @go(ObjectMeta)
	spec:     #MiddlewareTCPSpec @go(Spec)
}

// MiddlewareTCPSpec defines the desired state of a MiddlewareTCP.
#MiddlewareTCPSpec: {
	// InFlightConn defines the InFlightConn middleware configuration.
	inFlightConn?: null | dynamic.#TCPInFlightConn @go(InFlightConn,*dynamic.TCPInFlightConn)

	// IPWhiteList defines the IPWhiteList middleware configuration.
	ipWhiteList?: null | dynamic.#TCPIPWhiteList @go(IPWhiteList,*dynamic.TCPIPWhiteList)
}

// MiddlewareTCPList is a collection of MiddlewareTCP resources.
#MiddlewareTCPList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	metadata: metav1.#ListMeta @go(ListMeta)

	// Items is the list of MiddlewareTCP.
	items: [...#MiddlewareTCP] @go(Items,[]MiddlewareTCP)
}
