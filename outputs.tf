output "nifi_service_name" {
  description = "Nifi service name"
  value       = data.template_file.nomad_job_nifi.vars.service_name
}