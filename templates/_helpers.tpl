{{- define "booking-helm-test.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "booking-helm-test.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "booking-helm-test.labels" -}}
helm.sh/chart: {{ include "booking-helm-test.name" . }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "booking-helm-test.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "booking-helm-test.selectorLabels" -}}
app.kubernetes.io/name: {{ include "booking-helm-test.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
