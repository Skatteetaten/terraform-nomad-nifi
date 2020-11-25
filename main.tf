

data "template_file" "nomad_job_nifi" {
  template = file("${path.module}/conf/nomad/nifi.hcl")
}

resource "nomad_job" "nomad_job_nifi" {
  jobspec = data.template_file.nomad_job_nifi.rendered
  detach  = false
}