terraform {
  required_providers {
    todo = {
      source  = "spkane/todo"
      version = "2.0.5"
    }
   
    github = {
      source  = "integrations/github"
      version = ">= 5.3.0"
    }
  }
}

provider "todo" {
  host = "localhost"
  port = "8080"
  apipath = "/"
  schema = "http"
}


provider "github" {
  token = var.github_token
}

resource "todo_todo" "step_2" {
  count = 3
  description = "${count.index}: ${var.purpose} todo from step_2"
  completed = false
}


resource "todo_todo" "step_3" {
  for_each = {
    for repo in tolist(module.simple_example[*]):
    repo.github_repository.name => ({
      url = repo.github_repository.html_url
    })
  }

  description = "${each.value.url}: ${var.purpose} todo from step_3"
  completed = false
}



module "simple_example" {
  source  = "ksatirli/repository/github"
  count = var.create_repo ? 1:0
  version = "4.0.0"
  name       = "simple-example"
  visibility = "private"
  auto_init = true
}