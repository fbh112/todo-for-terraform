variable "purpose" {
    type = string
    description = "Tag the purpose of this todo"
    default = "testing-modules"
}


variable "github_token" {
    type = string
    description = "github personal token"
}

variable "create_repo" {
    type = bool
    default = true
}
