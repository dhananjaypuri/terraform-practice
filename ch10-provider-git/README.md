If we want to delete a specfic resource already created by terrafor then we need to run the below command

terraform destroy --target github_repository.gitrepo2 --auto-approve

terraform destroy --target <resource>.<resourcename> --auto-approve

terraform refresh ==> This command check the resource created a provider side and then update the tfstate file if some changed the configuration manually

terrafor output ==> This command print the outputs

terraform output <outputname>

terraform output repo2_url
"https://github.com/dhananjaypuri/terrform-repo2"

terraform console is used to print the variables which are being used this is used for debugging

terraform console

> github_repository.gitrepo2.html_url
"https://github.com/dhananjaypuri/terrform-repo2"
>
