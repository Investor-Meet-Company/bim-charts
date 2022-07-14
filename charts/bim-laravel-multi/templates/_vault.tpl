{{- define "vault.inject" -}}
vault.hashicorp.com/agent-inject: 'true'
vault.hashicorp.com/role: 'bb-{{ .Values.environment }}-role'
vault.hashicorp.com/agent-init-first: "true"
{{- end }}

{{- define "vault.env" -}}
vault.hashicorp.com/agent-inject-secret-env: 'kv/data/bb-{{ .Values.environment }}-env'
vault.hashicorp.com/agent-inject-template-env: |
  {{`{{ with secret "kv/data/bb-`}}{{ .Values.environment }}{{`-env" }}
    {{ range $key, $value := .Data.data  }}
    export {{ $key }}="{{ $value }}"
    {{ end }}
  {{ end }}`}}
{{- end }}


{{- define "vault.iam" -}}
vault.hashicorp.com/agent-inject-secret-iam: 'aws/creds/bb-{{ .Values.environment }}-access'
vault.hashicorp.com/agent-inject-template-iam: |
  {{`{{ with secret "aws/creds/bb-`}}{{ .Values.environment }}{{`-access" -}}
    [default]
    aws_access_key_id="{{ .Data.access_key }}"
    aws_secret_access_key="{{ .Data.secret_key }}"
  {{- end }}`}}
{{- end }}

{{- define "vault.db" -}}
vault.hashicorp.com/agent-inject-secret-db: 'database/creds/bb-{{ .Values.environment }}-access'
vault.hashicorp.com/agent-inject-template-db: |
  {{`{{ with secret "database/creds/bb-`}}{{ .Values.environment }}{{`-access" -}}
    export DB_USERNAME="{{ .Data.username }}"
    export DB_PASSWORD="{{ .Data.password }}"
  {{- end }}`}}
{{- end }}

{{- define "vault.creds" -}}
vault.hashicorp.com/agent-inject-secret-creds: 'database/creds/bb-{{ .Values.environment }}-access'
vault.hashicorp.com/agent-inject-template-creds: |
  {{`{{ with secret "database/creds/bb-`}}{{ .Values.environment }}{{`-access" -}}
    [client]
    user={{ .Data.username }}
    password={{ .Data.password }}
  {{- end }}`}}
{{- end }}

{{- define "vault.dns" -}}
vault.hashicorp.com/agent-inject-secret-dns: 'database/creds/bb-{{ .Values.environment }}-access'
vault.hashicorp.com/agent-inject-template-dns: |
  {{`{{ with secret "database/creds/bb-`}}{{ .Values.environment }}{{`-access" -}}
    mysql:`}}dbname={{ .Values.database.name }};host={{ .Values.database.host }};{{`user={{ .Data.username }};password={{ .Data.password }};
  {{- end }}`}}
{{- end }}

{{- define "vault.dns_read" -}}
vault.hashicorp.com/agent-inject-secret-dns_read: 'database/creds/bb-{{ .Values.environment }}-access'
vault.hashicorp.com/agent-inject-template-dns_read: |
{{`{{ with secret "database/creds/bb-`}}{{ .Values.environment }}{{`-access" -}}
    mysql:`}}dbname={{ .Values.database.name }};host={{ .Values.database.host_read }};{{`user={{ .Data.username }};password={{ .Data.password }};
{{- end }}`}}
{{- end }}