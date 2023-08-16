variable "prefix" {
  type = string
}

variable "account_ids" {
  type = map(string)
}

variable "users" {
  type = list(object({
    username = string
    email    = string
  }))
}