{{ define "pgbouncer.ini" }}

[databases]
{{- range $k, $v := .Values.databases }}
{{- $requiredMsg := printf ".Values.databases.%v needs to include .dbname" $k }}
{{ $k }} = host={{ $v.host }} port={{ $v.port }} {{ if $v.user }}user={{ $v.user }}{{end}} {{ if $v.dbname }}dbname={{ $v.dbname }}{{end}}
{{- end }}

[pgbouncer]
;;; Generic settings 
{{- range $k, $v := .Values.generic_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; Log settings
{{- range $k, $v := .Values.log_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; Console access control
{{- if and (not .Values.access_control_settings.admin_users) .Values.users }}
{{- $users := (join ", " (keys .Values.users | sortAlpha)) }}
admin_users = {{ $users }}
stats_users = {{ $users }}, stats, root, monitor
{{- else }}
{{- range $k, $v := .Values.access_control_settings }}
{{ $k }} = {{ $v }}
{{- end }}
{{- end }}

;;; Connection sanity checks, timeouts
{{- range $k, $v := .Values.timeout_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; TLS settings
{{- range $k, $v := .Values.tls_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; Dangerous timeouts
{{- range $k, $v := .Values.dangerous_timeout_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; Low-level network settings
{{- range $k, $v := .Values.network_settings }}
{{ $k }} = {{ $v }}
{{- end }}

;;; Additional pgbouncer settings
{{- range $k, $v := .Values.extra_settings }}
{{ $k }} = {{ $v }}
{{- end }}
{{ end }}
