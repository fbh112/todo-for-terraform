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


variable "repo_count" {
    type = number
    description = "the number of repo to crate"
    default = 1

    validation {
        condition = (var.repo_count >= 0 && var.repo_count <=3)
        error_message = "must be an integer from 1 to 3"
    }
}