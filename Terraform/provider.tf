terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
      
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region = "eu-gb"
}

