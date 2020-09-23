init:
	terraform init

ecs:
	terraform apply --var-file variable.tfvars

plan.ecs:
	terraform plan --var-file variable.tfvars

destroy:
	terraform destroy --var-file variable.tfvars
