terraform {
  required_version = "0.13.1"
    required_providers {
      goole = {
        source = "hashicorp/google"
        #version = "~> 3.65.0"
        version = "~> 4.11.0"
      }
      google-beta = {
        source = "hashicorp/google-beta"
        #version = "~> 3.65.0"
        version = "~> 4.11.0"
      }
    }
}