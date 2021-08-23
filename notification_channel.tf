resource "google_monitoring_notification_channel" "email_devops" {
  display_name = "DevOps Notification Channel"
  type         = "email"
  labels = {
    email_address = var.alerts_email_id
  }
}