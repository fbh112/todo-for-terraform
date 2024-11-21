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

locals {
  class = "this is from O'Reilly"
  remaining_step2 = [for t in todo_todo.step_2: t.description if t.completed==false]
}


resource "todo_todo" "remaining" {
  description = "${local.class} has asked us to complete these! (${join(",", local.remaining_step2)})"
  completed = false
}

module "simple_example" {
  source  = "ksatirli/repository/github"
  count = var.repo_count
  version = "4.0.0"
  name       = "simple-example-${count.index}"
  description = "this repo created by terraform index=${count.index+1} outof ${var.repo_count}"
  visibility = "private"
  auto_init = true
}