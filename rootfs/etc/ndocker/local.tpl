#
{{- $consul_user_prefs := env "CONSUL_SA_USER_PREFS" }}
{{- if eq $consul_user_prefs "true" }}
{{ key "amavis/user_prefs" }}
{{- end }}
