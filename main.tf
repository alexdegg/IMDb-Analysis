terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
  required_version = ">= 0.12"
}

provider "google" {
  credentials = file("~/.gc/gcp_key.json") # Adjust the path as needed
  project     = "refined-outlet-411413"
  region      = "europe-west3" # Corrected region format
}

resource "google_storage_bucket" "my_bucket" {
  name     = "imdb-bucket-de-zoomcamp" # Ensure the bucket name is globally unique
  location = "EU"
}

resource "google_storage_bucket_object" "object" {
  for_each = fileset("${path.module}", "**/*")
  name     = each.value
  bucket   = google_storage_bucket.my_bucket.name
  source   = "${path.module}/${each.value}"
}
