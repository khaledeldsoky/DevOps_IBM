{{/*
Expand the name of the chart.
*/}}
{{- define "argocd.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We use .Release.Name to avoid conflicts if the same chart is installed multiple times.
*/}}
{{- define "argocd.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
