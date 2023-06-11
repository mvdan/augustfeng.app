// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/traefik/traefik/v2/pkg/config/dynamic

package dynamic

// TCPMiddleware holds the TCPMiddleware configuration.
#TCPMiddleware: {
	inFlightConn?: null | #TCPInFlightConn @go(InFlightConn,*TCPInFlightConn) @toml(inFlightConn,omitempty)
	ipWhiteList?:  null | #TCPIPWhiteList  @go(IPWhiteList,*TCPIPWhiteList) @toml(ipWhiteList,omitempty)
}

// TCPInFlightConn holds the TCP InFlightConn middleware configuration.
// This middleware prevents services from being overwhelmed with high load,
// by limiting the number of allowed simultaneous connections for one IP.
// More info: https://doc.traefik.io/traefik/v2.10/middlewares/tcp/inflightconn/
#TCPInFlightConn: {
	// Amount defines the maximum amount of allowed simultaneous connections.
	// The middleware closes the connection if there are already amount connections opened.
	amount?: int64 @go(Amount) @toml(amount,omitempty)
}

// TCPIPWhiteList holds the TCP IPWhiteList middleware configuration.
// This middleware accepts/refuses connections based on the client IP.
#TCPIPWhiteList: {
	// SourceRange defines the allowed IPs (or ranges of allowed IPs by using CIDR notation).
	sourceRange?: [...string] @go(SourceRange,[]string) @toml(sourceRange,omitempty)
}
