// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go crypto/x509

// Package x509 parses X.509-encoded keys and certificates.
package x509

import (
	"crypto/x509/pkix"
	"encoding/asn1"
	"time"
	"net/url"
	"net"
)

// pkixPublicKey reflects a PKIX public key structure. See SubjectPublicKeyInfo
// in RFC 3280.
_#pkixPublicKey: {
	Algo:      pkix.#AlgorithmIdentifier
	BitString: asn1.#BitString
}

_#certificate: {
	Raw:                asn1.#RawContent
	TBSCertificate:     _#tbsCertificate
	SignatureAlgorithm: pkix.#AlgorithmIdentifier
	SignatureValue:     asn1.#BitString
}

_#tbsCertificate: {
	Raw:                asn1.#RawContent
	Version:            int
	SerialNumber?:      null | int @go(,*big.Int)
	SignatureAlgorithm: pkix.#AlgorithmIdentifier
	Issuer:             asn1.#RawValue
	Validity:           _#validity
	Subject:            asn1.#RawValue
	PublicKey:          _#publicKeyInfo
	UniqueId:           asn1.#BitString
	SubjectUniqueId:    asn1.#BitString
	Extensions: [...pkix.#Extension] @go(,[]pkix.Extension)
}

_#dsaAlgorithmParameters: {
	P?: null | int @go(,*big.Int)
	Q?: null | int @go(,*big.Int)
	G?: null | int @go(,*big.Int)
}

_#validity: {
	NotBefore: time.Time
	NotAfter:  time.Time
}

_#publicKeyInfo: {
	Raw:       asn1.#RawContent
	Algorithm: pkix.#AlgorithmIdentifier
	PublicKey: asn1.#BitString
}

// RFC 5280,  4.2.1.1
_#authKeyId: {
	Id: bytes @go(,[]byte)
}

#SignatureAlgorithm: int // #enumSignatureAlgorithm

#enumSignatureAlgorithm:
	#UnknownSignatureAlgorithm |
	#MD2WithRSA |
	#MD5WithRSA |
	#SHA1WithRSA |
	#SHA256WithRSA |
	#SHA384WithRSA |
	#SHA512WithRSA |
	#DSAWithSHA1 |
	#DSAWithSHA256 |
	#ECDSAWithSHA1 |
	#ECDSAWithSHA256 |
	#ECDSAWithSHA384 |
	#ECDSAWithSHA512 |
	#SHA256WithRSAPSS |
	#SHA384WithRSAPSS |
	#SHA512WithRSAPSS |
	#PureEd25519

#values_SignatureAlgorithm: {
	UnknownSignatureAlgorithm: #UnknownSignatureAlgorithm
	MD2WithRSA:                #MD2WithRSA
	MD5WithRSA:                #MD5WithRSA
	SHA1WithRSA:               #SHA1WithRSA
	SHA256WithRSA:             #SHA256WithRSA
	SHA384WithRSA:             #SHA384WithRSA
	SHA512WithRSA:             #SHA512WithRSA
	DSAWithSHA1:               #DSAWithSHA1
	DSAWithSHA256:             #DSAWithSHA256
	ECDSAWithSHA1:             #ECDSAWithSHA1
	ECDSAWithSHA256:           #ECDSAWithSHA256
	ECDSAWithSHA384:           #ECDSAWithSHA384
	ECDSAWithSHA512:           #ECDSAWithSHA512
	SHA256WithRSAPSS:          #SHA256WithRSAPSS
	SHA384WithRSAPSS:          #SHA384WithRSAPSS
	SHA512WithRSAPSS:          #SHA512WithRSAPSS
	PureEd25519:               #PureEd25519
}

#UnknownSignatureAlgorithm: #SignatureAlgorithm & 0
#MD2WithRSA:                #SignatureAlgorithm & 1
#MD5WithRSA:                #SignatureAlgorithm & 2
#SHA1WithRSA:               #SignatureAlgorithm & 3
#SHA256WithRSA:             #SignatureAlgorithm & 4
#SHA384WithRSA:             #SignatureAlgorithm & 5
#SHA512WithRSA:             #SignatureAlgorithm & 6
#DSAWithSHA1:               #SignatureAlgorithm & 7
#DSAWithSHA256:             #SignatureAlgorithm & 8
#ECDSAWithSHA1:             #SignatureAlgorithm & 9
#ECDSAWithSHA256:           #SignatureAlgorithm & 10
#ECDSAWithSHA384:           #SignatureAlgorithm & 11
#ECDSAWithSHA512:           #SignatureAlgorithm & 12
#SHA256WithRSAPSS:          #SignatureAlgorithm & 13
#SHA384WithRSAPSS:          #SignatureAlgorithm & 14
#SHA512WithRSAPSS:          #SignatureAlgorithm & 15
#PureEd25519:               #SignatureAlgorithm & 16

#PublicKeyAlgorithm: int // #enumPublicKeyAlgorithm

#enumPublicKeyAlgorithm:
	#UnknownPublicKeyAlgorithm |
	#RSA |
	#DSA |
	#ECDSA |
	#Ed25519

#values_PublicKeyAlgorithm: {
	UnknownPublicKeyAlgorithm: #UnknownPublicKeyAlgorithm
	RSA:                       #RSA
	DSA:                       #DSA
	ECDSA:                     #ECDSA
	Ed25519:                   #Ed25519
}

#UnknownPublicKeyAlgorithm: #PublicKeyAlgorithm & 0
#RSA:                       #PublicKeyAlgorithm & 1
#DSA:                       #PublicKeyAlgorithm & 2
#ECDSA:                     #PublicKeyAlgorithm & 3
#Ed25519:                   #PublicKeyAlgorithm & 4

// pssParameters reflects the parameters in an AlgorithmIdentifier that
// specifies RSA PSS. See RFC 3447, Appendix A.2.3.
_#pssParameters: {
	// The following three fields are not marked as
	// optional because the default values specify SHA-1,
	// which is no longer suitable for use in signatures.
	Hash:         pkix.#AlgorithmIdentifier
	MGF:          pkix.#AlgorithmIdentifier
	SaltLength:   int
	TrailerField: int
}

// KeyUsage represents the set of actions that are valid for a given key. It's
// a bitmap of the KeyUsage* constants.
#KeyUsage: int // #enumKeyUsage

#enumKeyUsage:
	#KeyUsageDigitalSignature |
	#KeyUsageContentCommitment |
	#KeyUsageKeyEncipherment |
	#KeyUsageDataEncipherment |
	#KeyUsageKeyAgreement |
	#KeyUsageCertSign |
	#KeyUsageCRLSign |
	#KeyUsageEncipherOnly |
	#KeyUsageDecipherOnly

#values_KeyUsage: {
	KeyUsageDigitalSignature:  #KeyUsageDigitalSignature
	KeyUsageContentCommitment: #KeyUsageContentCommitment
	KeyUsageKeyEncipherment:   #KeyUsageKeyEncipherment
	KeyUsageDataEncipherment:  #KeyUsageDataEncipherment
	KeyUsageKeyAgreement:      #KeyUsageKeyAgreement
	KeyUsageCertSign:          #KeyUsageCertSign
	KeyUsageCRLSign:           #KeyUsageCRLSign
	KeyUsageEncipherOnly:      #KeyUsageEncipherOnly
	KeyUsageDecipherOnly:      #KeyUsageDecipherOnly
}

#KeyUsageDigitalSignature:  #KeyUsage & 1
#KeyUsageContentCommitment: #KeyUsage & 2
#KeyUsageKeyEncipherment:   #KeyUsage & 4
#KeyUsageDataEncipherment:  #KeyUsage & 8
#KeyUsageKeyAgreement:      #KeyUsage & 16
#KeyUsageCertSign:          #KeyUsage & 32
#KeyUsageCRLSign:           #KeyUsage & 64
#KeyUsageEncipherOnly:      #KeyUsage & 128
#KeyUsageDecipherOnly:      #KeyUsage & 256

// ExtKeyUsage represents an extended set of actions that are valid for a given key.
// Each of the ExtKeyUsage* constants define a unique action.
#ExtKeyUsage: int // #enumExtKeyUsage

#enumExtKeyUsage:
	#ExtKeyUsageAny |
	#ExtKeyUsageServerAuth |
	#ExtKeyUsageClientAuth |
	#ExtKeyUsageCodeSigning |
	#ExtKeyUsageEmailProtection |
	#ExtKeyUsageIPSECEndSystem |
	#ExtKeyUsageIPSECTunnel |
	#ExtKeyUsageIPSECUser |
	#ExtKeyUsageTimeStamping |
	#ExtKeyUsageOCSPSigning |
	#ExtKeyUsageMicrosoftServerGatedCrypto |
	#ExtKeyUsageNetscapeServerGatedCrypto |
	#ExtKeyUsageMicrosoftCommercialCodeSigning |
	#ExtKeyUsageMicrosoftKernelCodeSigning

#values_ExtKeyUsage: {
	ExtKeyUsageAny:                            #ExtKeyUsageAny
	ExtKeyUsageServerAuth:                     #ExtKeyUsageServerAuth
	ExtKeyUsageClientAuth:                     #ExtKeyUsageClientAuth
	ExtKeyUsageCodeSigning:                    #ExtKeyUsageCodeSigning
	ExtKeyUsageEmailProtection:                #ExtKeyUsageEmailProtection
	ExtKeyUsageIPSECEndSystem:                 #ExtKeyUsageIPSECEndSystem
	ExtKeyUsageIPSECTunnel:                    #ExtKeyUsageIPSECTunnel
	ExtKeyUsageIPSECUser:                      #ExtKeyUsageIPSECUser
	ExtKeyUsageTimeStamping:                   #ExtKeyUsageTimeStamping
	ExtKeyUsageOCSPSigning:                    #ExtKeyUsageOCSPSigning
	ExtKeyUsageMicrosoftServerGatedCrypto:     #ExtKeyUsageMicrosoftServerGatedCrypto
	ExtKeyUsageNetscapeServerGatedCrypto:      #ExtKeyUsageNetscapeServerGatedCrypto
	ExtKeyUsageMicrosoftCommercialCodeSigning: #ExtKeyUsageMicrosoftCommercialCodeSigning
	ExtKeyUsageMicrosoftKernelCodeSigning:     #ExtKeyUsageMicrosoftKernelCodeSigning
}

#ExtKeyUsageAny:                            #ExtKeyUsage & 0
#ExtKeyUsageServerAuth:                     #ExtKeyUsage & 1
#ExtKeyUsageClientAuth:                     #ExtKeyUsage & 2
#ExtKeyUsageCodeSigning:                    #ExtKeyUsage & 3
#ExtKeyUsageEmailProtection:                #ExtKeyUsage & 4
#ExtKeyUsageIPSECEndSystem:                 #ExtKeyUsage & 5
#ExtKeyUsageIPSECTunnel:                    #ExtKeyUsage & 6
#ExtKeyUsageIPSECUser:                      #ExtKeyUsage & 7
#ExtKeyUsageTimeStamping:                   #ExtKeyUsage & 8
#ExtKeyUsageOCSPSigning:                    #ExtKeyUsage & 9
#ExtKeyUsageMicrosoftServerGatedCrypto:     #ExtKeyUsage & 10
#ExtKeyUsageNetscapeServerGatedCrypto:      #ExtKeyUsage & 11
#ExtKeyUsageMicrosoftCommercialCodeSigning: #ExtKeyUsage & 12
#ExtKeyUsageMicrosoftKernelCodeSigning:     #ExtKeyUsage & 13

// A Certificate represents an X.509 certificate.
#Certificate: {
	Raw:                     bytes @go(,[]byte)
	RawTBSCertificate:       bytes @go(,[]byte)
	RawSubjectPublicKeyInfo: bytes @go(,[]byte)
	RawSubject:              bytes @go(,[]byte)
	RawIssuer:               bytes @go(,[]byte)
	Signature:               bytes @go(,[]byte)
	SignatureAlgorithm:      #SignatureAlgorithm
	PublicKeyAlgorithm:      #PublicKeyAlgorithm
	PublicKey:               _ @go(,any)
	Version:                 int
	SerialNumber?:           null | int @go(,*big.Int)
	Issuer:                  pkix.#Name
	Subject:                 pkix.#Name
	NotBefore:               time.Time
	NotAfter:                time.Time
	KeyUsage:                #KeyUsage

	// Extensions contains raw X.509 extensions. When parsing certificates,
	// this can be used to extract non-critical extensions that are not
	// parsed by this package. When marshaling certificates, the Extensions
	// field is ignored, see ExtraExtensions.
	Extensions: [...pkix.#Extension] @go(,[]pkix.Extension)

	// ExtraExtensions contains extensions to be copied, raw, into any
	// marshaled certificates. Values override any extensions that would
	// otherwise be produced based on the other fields. The ExtraExtensions
	// field is not populated when parsing certificates, see Extensions.
	ExtraExtensions: [...pkix.#Extension] @go(,[]pkix.Extension)

	// UnhandledCriticalExtensions contains a list of extension IDs that
	// were not (fully) processed when parsing. Verify will fail if this
	// slice is non-empty, unless verification is delegated to an OS
	// library which understands all the critical extensions.
	//
	// Users can access these extensions using Extensions and can remove
	// elements from this slice if they believe that they have been
	// handled.
	UnhandledCriticalExtensions: [...asn1.#ObjectIdentifier] @go(,[]asn1.ObjectIdentifier)
	ExtKeyUsage: [...#ExtKeyUsage] @go(,[]ExtKeyUsage)
	UnknownExtKeyUsage: [...asn1.#ObjectIdentifier] @go(,[]asn1.ObjectIdentifier)

	// BasicConstraintsValid indicates whether IsCA, MaxPathLen,
	// and MaxPathLenZero are valid.
	BasicConstraintsValid: bool
	IsCA:                  bool

	// MaxPathLen and MaxPathLenZero indicate the presence and
	// value of the BasicConstraints' "pathLenConstraint".
	//
	// When parsing a certificate, a positive non-zero MaxPathLen
	// means that the field was specified, -1 means it was unset,
	// and MaxPathLenZero being true mean that the field was
	// explicitly set to zero. The case of MaxPathLen==0 with MaxPathLenZero==false
	// should be treated equivalent to -1 (unset).
	//
	// When generating a certificate, an unset pathLenConstraint
	// can be requested with either MaxPathLen == -1 or using the
	// zero value for both MaxPathLen and MaxPathLenZero.
	MaxPathLen: int

	// MaxPathLenZero indicates that BasicConstraintsValid==true
	// and MaxPathLen==0 should be interpreted as an actual
	// maximum path length of zero. Otherwise, that combination is
	// interpreted as MaxPathLen not being set.
	MaxPathLenZero: bool
	SubjectKeyId:   bytes @go(,[]byte)
	AuthorityKeyId: bytes @go(,[]byte)

	// RFC 5280, 4.2.2.1 (Authority Information Access)
	OCSPServer: [...string] @go(,[]string)
	IssuingCertificateURL: [...string] @go(,[]string)

	// Subject Alternate Name values. (Note that these values may not be valid
	// if invalid values were contained within a parsed certificate. For
	// example, an element of DNSNames may not be a valid DNS domain name.)
	DNSNames: [...string] @go(,[]string)
	EmailAddresses: [...string] @go(,[]string)
	IPAddresses: [...string] @go(,[]net.IP)
	URIs: [...null | url.#URL] @go(,[]*url.URL)

	// Name constraints
	PermittedDNSDomainsCritical: bool
	PermittedDNSDomains: [...string] @go(,[]string)
	ExcludedDNSDomains: [...string] @go(,[]string)
	PermittedIPRanges: [...null | net.#IPNet] @go(,[]*net.IPNet)
	ExcludedIPRanges: [...null | net.#IPNet] @go(,[]*net.IPNet)
	PermittedEmailAddresses: [...string] @go(,[]string)
	ExcludedEmailAddresses: [...string] @go(,[]string)
	PermittedURIDomains: [...string] @go(,[]string)
	ExcludedURIDomains: [...string] @go(,[]string)

	// CRL Distribution Points
	CRLDistributionPoints: [...string] @go(,[]string)
	PolicyIdentifiers: [...asn1.#ObjectIdentifier] @go(,[]asn1.ObjectIdentifier)
}

// An InsecureAlgorithmError indicates that the SignatureAlgorithm used to
// generate the signature is not secure, and the signature has been rejected.
//
// To temporarily restore support for SHA-1 signatures, include the value
// "x509sha1=1" in the GODEBUG environment variable. Note that this option will
// be removed in a future release.
#InsecureAlgorithmError: #SignatureAlgorithm

// ConstraintViolationError results when a requested usage is not permitted by
// a certificate. For example: checking a signature when the public key isn't a
// certificate signing key.
#ConstraintViolationError: {
}

#UnhandledCriticalExtension: {
}

_#basicConstraints: {
	IsCA:       bool
	MaxPathLen: int
}

// RFC 5280 4.2.1.4
_#policyInformation: {
	Policy: asn1.#ObjectIdentifier
}

_#nameTypeEmail: 1
_#nameTypeDNS:   2
_#nameTypeURI:   6
_#nameTypeIP:    7

// RFC 5280, 4.2.2.1
_#authorityInfoAccess: {
	Method:   asn1.#ObjectIdentifier
	Location: asn1.#RawValue
}

// RFC 5280, 4.2.1.14
_#distributionPoint: {
	DistributionPoint: _#distributionPointName
	Reason:            asn1.#BitString
	CRLIssuer:         asn1.#RawValue
}

_#distributionPointName: {
	FullName: [...asn1.#RawValue] @go(,[]asn1.RawValue)
	RelativeName: pkix.#RDNSequence
}

// CertificateRequest represents a PKCS #10, certificate signature request.
#CertificateRequest: {
	Raw:                      bytes @go(,[]byte)
	RawTBSCertificateRequest: bytes @go(,[]byte)
	RawSubjectPublicKeyInfo:  bytes @go(,[]byte)
	RawSubject:               bytes @go(,[]byte)
	Version:                  int
	Signature:                bytes @go(,[]byte)
	SignatureAlgorithm:       #SignatureAlgorithm
	PublicKeyAlgorithm:       #PublicKeyAlgorithm
	PublicKey:                _ @go(,any)
	Subject:                  pkix.#Name

	// Attributes contains the CSR attributes that can parse as
	// pkix.AttributeTypeAndValueSET.
	//
	// Deprecated: Use Extensions and ExtraExtensions instead for parsing and
	// generating the requestedExtensions attribute.
	Attributes: [...pkix.#AttributeTypeAndValueSET] @go(,[]pkix.AttributeTypeAndValueSET)

	// Extensions contains all requested extensions, in raw form. When parsing
	// CSRs, this can be used to extract extensions that are not parsed by this
	// package.
	Extensions: [...pkix.#Extension] @go(,[]pkix.Extension)

	// ExtraExtensions contains extensions to be copied, raw, into any CSR
	// marshaled by CreateCertificateRequest. Values override any extensions
	// that would otherwise be produced based on the other fields but are
	// overridden by any extensions specified in Attributes.
	//
	// The ExtraExtensions field is not populated by ParseCertificateRequest,
	// see Extensions instead.
	ExtraExtensions: [...pkix.#Extension] @go(,[]pkix.Extension)

	// Subject Alternate Name values.
	DNSNames: [...string] @go(,[]string)
	EmailAddresses: [...string] @go(,[]string)
	IPAddresses: [...string] @go(,[]net.IP)
	URIs: [...null | url.#URL] @go(,[]*url.URL)
}

_#tbsCertificateRequest: {
	Raw:       asn1.#RawContent
	Version:   int
	Subject:   asn1.#RawValue
	PublicKey: _#publicKeyInfo
	RawAttributes: [...asn1.#RawValue] @go(,[]asn1.RawValue)
}

_#certificateRequest: {
	Raw:                asn1.#RawContent
	TBSCSR:             _#tbsCertificateRequest
	SignatureAlgorithm: pkix.#AlgorithmIdentifier
	SignatureValue:     asn1.#BitString
}

// RevocationList contains the fields used to create an X.509 v2 Certificate
// Revocation list with CreateRevocationList.
#RevocationList: {
	// Raw contains the complete ASN.1 DER content of the CRL (tbsCertList,
	// signatureAlgorithm, and signatureValue.)
	Raw: bytes @go(,[]byte)

	// RawTBSRevocationList contains just the tbsCertList portion of the ASN.1
	// DER.
	RawTBSRevocationList: bytes @go(,[]byte)

	// RawIssuer contains the DER encoded Issuer.
	RawIssuer: bytes @go(,[]byte)

	// Issuer contains the DN of the issuing certificate.
	Issuer: pkix.#Name

	// AuthorityKeyId is used to identify the public key associated with the
	// issuing certificate. It is populated from the authorityKeyIdentifier
	// extension when parsing a CRL. It is ignored when creating a CRL; the
	// extension is populated from the issuing certificate itself.
	AuthorityKeyId: bytes @go(,[]byte)
	Signature:      bytes @go(,[]byte)

	// SignatureAlgorithm is used to determine the signature algorithm to be
	// used when signing the CRL. If 0 the default algorithm for the signing
	// key will be used.
	SignatureAlgorithm: #SignatureAlgorithm

	// RevokedCertificates is used to populate the revokedCertificates
	// sequence in the CRL, it may be empty. RevokedCertificates may be nil,
	// in which case an empty CRL will be created.
	RevokedCertificates: [...pkix.#RevokedCertificate] @go(,[]pkix.RevokedCertificate)

	// Number is used to populate the X.509 v2 cRLNumber extension in the CRL,
	// which should be a monotonically increasing sequence number for a given
	// CRL scope and CRL issuer. It is also populated from the cRLNumber
	// extension when parsing a CRL.
	Number?: null | int @go(,*big.Int)

	// ThisUpdate is used to populate the thisUpdate field in the CRL, which
	// indicates the issuance date of the CRL.
	ThisUpdate: time.Time

	// NextUpdate is used to populate the nextUpdate field in the CRL, which
	// indicates the date by which the next CRL will be issued. NextUpdate
	// must be greater than ThisUpdate.
	NextUpdate: time.Time

	// Extensions contains raw X.509 extensions. When creating a CRL,
	// the Extensions field is ignored, see ExtraExtensions.
	Extensions: [...pkix.#Extension] @go(,[]pkix.Extension)

	// ExtraExtensions contains any additional extensions to add directly to
	// the CRL.
	ExtraExtensions: [...pkix.#Extension] @go(,[]pkix.Extension)
}
