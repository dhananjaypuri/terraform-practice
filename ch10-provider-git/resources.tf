resource "github_repository" "gitrepo1" {
  name        = "terrform-repo1"
  description = "Repository created by terraform"

  visibility = "public"
  auto_init = true

}

resource "github_repository" "gitrepo2" {
  name        = "terrform-repo2"
  description = "Repository created by terraform"

  visibility = "public"
  auto_init = true

}
