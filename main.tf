provider "google" {
  credentials = "${file(var.credentials_path)}"
}

module "gsuite-export" {
  source          = "github.com/terraform-google-modules/terraform-google-gsuite-export"
  service_account = "${var.service_account}"
  api             = "${var.api}"
  applications    = "${var.applications}"
  admin_user      = "${var.admin_user}"
  project_id      = "${var.project_id}"
  machine_name    = "${var.machine_name}"
  machine_zone    = "us-central1-f"
  export_filter   = "${var.filter}"
  frequency       = "${var.frequency}"
}

module "log_export" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = "${module.destination.destination_uri}"
  filter                 = "${module.gsuite-export.filter}"
  log_sink_name          = "pubsub_example_logsink"
  parent_resource_id     = "${var.project_id}"
  parent_resource_type   = "project"
  unique_writer_identity = "true"
}

module "destination" {
  source                   = "terraform-google-modules/log-export/google//modules/pubsub"
  project_id               = "${var.project_id}"
  topic_name               = "drive-log-stream"
  log_sink_writer_identity = "${module.log_export.writer_identity}"
  create_subscriber        = "true"
}
