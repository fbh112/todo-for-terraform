output "todo_ids" {
  value = todo_todo.step_2.*.id
}

output "todo_ids_repourl" {
  value = {
    for k, v in todo_todo.step_3 : k => v.id
  }
}

output "repo_uri" {
  value = module.simple_example[0].github_repository.html_url
}