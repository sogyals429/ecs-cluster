ecs:
	terraform apply --var-file variable.tfvars

destroy:
	terraform destroy --var-file variable.tfvars
