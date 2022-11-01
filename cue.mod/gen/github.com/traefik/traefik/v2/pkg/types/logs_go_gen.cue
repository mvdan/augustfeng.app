// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/traefik/traefik/v2/pkg/types

package types

// AccessLogKeep is the keep string value.
#AccessLogKeep: "keep"

// AccessLogDrop is the drop string value.
#AccessLogDrop: "drop"

// AccessLogRedact is the redact string value.
#AccessLogRedact: "redact"

// CommonFormat is the common logging format (CLF).
#CommonFormat: "common"

// JSONFormat is the JSON logging format.
#JSONFormat: "json"

// TraefikLog holds the configuration settings for the traefik logger.
#TraefikLog: {
	level?:    string @go(Level) @toml(level,omitempty)
	filePath?: string @go(FilePath) @toml(filePath,omitempty)
	format?:   string @go(Format) @toml(format,omitempty)
}

// AccessLog holds the configuration settings for the access logger (middlewares/accesslog).
#AccessLog: {
	filePath?:      string                   @go(FilePath) @toml(filePath,omitempty)
	format?:        string                   @go(Format) @toml(format,omitempty)
	filters?:       null | #AccessLogFilters @go(Filters,*AccessLogFilters) @toml(filters,omitempty)
	fields?:        null | #AccessLogFields  @go(Fields,*AccessLogFields) @toml(fields,omitempty)
	bufferingSize?: int64                    @go(BufferingSize) @toml(bufferingSize,omitempty)
}

// AccessLogFilters holds filters configuration.
#AccessLogFilters: {
	statusCodes?: [...string] @go(StatusCodes,[]string) @toml(statusCodes,omitempty)
	retryAttempts?: bool @go(RetryAttempts) @toml(retryAttempts,omitempty)
}

// FieldHeaders holds configuration for access log headers.
#FieldHeaders: {
	defaultMode?: string @go(DefaultMode) @toml(defaultMode,omitempty)
	names?: {[string]: string} @go(Names,map[string]string) @toml(names,omitempty)
}

// AccessLogFields holds configuration for access log fields.
#AccessLogFields: {
	defaultMode?: string @go(DefaultMode) @toml(defaultMode,omitempty)
	names?: {[string]: string} @go(Names,map[string]string) @toml(names,omitempty)
	headers?: null | #FieldHeaders @go(Headers,*FieldHeaders) @toml(headers,omitempty)
}
