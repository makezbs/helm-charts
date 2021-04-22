{{ define "userlist.txt" }}
{{- range $k, $v := .Values.users }}
{{ $k | quote }} {{ $v | quote }}
{{- end }}
{{- end }}
