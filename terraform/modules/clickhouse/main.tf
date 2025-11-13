terraform {
  required_version = ">= 1.13.4"
  required_providers {
    kubernetes = { source = "hashicorp/kubernetes", version = ">= 2.31" }
    helm       = { source = "hashicorp/helm", version = ">= 2.11" }
  }
}

resource "kubernetes_namespace" "clickhouse" {
  metadata {
    name = var.namespace
    labels = {
      "app.kubernetes.io/name" = "clickhouse"
    }
  }
}

resource "helm_release" "clickhouse_operator" {
  name             = "clickhouse-operator"
  namespace        = kubernetes_namespace.clickhouse.metadata[0].name
  repository       = "https://altinity.github.io/clickhouse-operator/"
  chart            = "clickhouse-operator"
  version          = var.operator_chart_version
  create_namespace = false

  values = [
    yamlencode({
      image           = { tag = var.operator_image_tag }
      metrics         = { enabled = true }
      watchNamespaces = [kubernetes_namespace.clickhouse.metadata[0].name]
    })
  ]
}

locals {
  pod_template = {
    name = "clickhouse-pod"
    spec = {
      containers = [{
        name  = "clickhouse"
        image = "altinity/clickhouse-server:${var.clickhouse_version}"
        resources = {
          requests = {
            cpu    = var.cpu_request
            memory = var.memory_request
          }
          limits = {
            cpu    = var.cpu_limit
            memory = var.memory_limit
          }
        }
        volumeMounts = [{
          name      = "data"
          mountPath = "/var/lib/clickhouse"
        }]
      }]
      tolerations = var.tolerations
      affinity    = var.affinity
    }
  }

  volume_template = {
    name = "data"
    spec = {
      accessModes = ["ReadWriteOnce"]
      resources = {
        requests = {
          storage = var.disk_size
        }
      }
      storageClassName = var.storage_class
    }
  }
}

resource "kubernetes_manifest" "clickhouse_installation" {
  manifest = {
    apiVersion = "clickhouse.altinity.com/v1"
    kind       = "ClickHouseInstallation"
    metadata = {
      name      = var.clickhouse_release_name
      namespace = kubernetes_namespace.clickhouse.metadata[0].name
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    }
    spec = {
      defaults = {
        templates = {
          podTemplate             = local.pod_template.name
          dataVolumeClaimTemplate = local.volume_template.name
        }
      }
      configuration = {
        clusters = [
          {
            name = "analytics"
            layout = {
              shardsCount   = var.shards
              replicasCount = var.replicas
            }
            templates = {
              podTemplate             = local.pod_template.name
              dataVolumeClaimTemplate = local.volume_template.name
            }
          }
        ]
      }
      templates = {
        podTemplates         = [local.pod_template]
        volumeClaimTemplates = [local.volume_template]
      }
    }
  }

  depends_on = [
    helm_release.clickhouse_operator
  ]
}
