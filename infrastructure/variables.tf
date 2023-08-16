variable "prefix" {
  type = string
}

variable "provider_type" {
  type = string
}

variable "docker_hub_access_token" {
  type        = string
  description = "Docker Hub access token"
}

variable "docker_hub_username" {
  type        = string
  description = "Docker Hub username"
}