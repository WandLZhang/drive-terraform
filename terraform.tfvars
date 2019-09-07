credentials_path = "/terraform-credentials.json"

admin_user = "williszhang@admin.altostrat.com"

service_account = " terraform@va-remediation-201909.iam.gserviceaccount.com"

api = "reports_v1"

applications = "drive"

project_id = "va-remediation-201909"

machine_name = "gsuite-exporter"

export_name = "drive_stream"

filter = "logName=projects/va-remediation-201909/logs/drive AND change_document_visibility"

frequency = "*/1 * * * *"
