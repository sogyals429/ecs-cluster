init:
	terraform init

ecs:
	terraform apply --var-file ../tf_vars/variable.tfvars

plan.ecs:
	terraform plan --var-file ../tf_vars/variable.tfvars

destroy:
	terraform destroy --var-file ../tf_vars/variable.tfvars
