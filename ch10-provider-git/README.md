If we want to delete a specfic resource already created by terrafor then we need to run the below command

terraform destroy --target github_repository.gitrepo2 --auto-approve

terraform destroy --target <resource>.<resourcename> --auto-approve
