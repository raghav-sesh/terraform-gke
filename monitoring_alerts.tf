resource "google_monitoring_alert_policy" "cpu_alert_policy" {
  display_name = "Node CPU Alert Policy"
  combiner     = "OR"
  conditions {
        display_name = "mql"
        condition_monitoring_query_language {
          query = "fetch k8s_node | metric 'kubernetes.io/node/cpu/allocatable_utilization' | filter (resource.cluster_name == '${google_container_cluster.raghav_cluster.name}') | group_by 1m,     [value_allocatable_utilization_mean: mean(value.allocatable_utilization)] | every 1m | group_by [],  [value_allocatable_utilization_mean_mean: mean(value_allocatable_utilization_mean)] | condition val() > 0.8 '1'"
          duration = "60s"
        }
    }
  user_labels = {
    created_by = "raghav"
  }
  notification_channels = [google_monitoring_notification_channel.email_devops.id]

}

resource "google_monitoring_alert_policy" "memory_alert_policy" {
  display_name = "Node Memory Alert Policy"
  combiner     = "OR"
  conditions {
        display_name = "mql"
        condition_monitoring_query_language {
          query = "fetch k8s_node | metric 'kubernetes.io/node/memory/allocatable_utilization' | filter (resource.cluster_name == '${google_container_cluster.raghav_cluster.name}') | group_by 1m,    [value_allocatable_utilization_mean: mean(value.allocatable_utilization)] | every 1m | group_by [],  [value_allocatable_utilization_mean_mean: mean(value_allocatable_utilization_mean)] | condition val() > 0.8 '1'"
          duration = "60s"
        }
    }
  user_labels = {
    created_by = "raghav"
  }
  notification_channels = [google_monitoring_notification_channel.email_devops.id]

}

