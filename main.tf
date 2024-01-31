terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_storage_bucket" "test" {
  name          = var.gcs_bucket_name
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_compute_address" "external_ip" {
  project      = var.project # Replace this with your service project ID in quotes
  name         = "ipv6-address"
  region = "us-central1"
}

resource "google_compute_instance" "default" {
  machine_type = "e2-standard-4"
  name         = "dezoomcamp2024"
  project      = "dezoomcamp-412116"
  zone         = "us-central1-a"

  boot_disk {
    auto_delete = true
    device_name = "dezoomcamp2024"
    mode        = "READ_WRITE"
    initialize_params {
      enable_confidential_compute = false
      image                       = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240110"
      labels                      = {}
      resource_manager_tags       = {}
      size                        = 30
      type                        = "pd-balanced"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    network                     = "https://www.googleapis.com/compute/v1/projects/dezoomcamp-412116/global/networks/default"
    network_ip                  = "10.128.0.2"
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = "https://www.googleapis.com/compute/v1/projects/dezoomcamp-412116/regions/us-central1/subnetworks/default"
    subnetwork_project          = "dezoomcamp-412116"
    access_config {
      nat_ip = google_compute_address.external_ip.address 
    }
  }

  reservation_affinity {
    type = "ANY_RESERVATION"
  }
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
