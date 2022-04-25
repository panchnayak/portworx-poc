install:
	echo "install terraform before executing this"
init:
	cd px-rancher && terraform init
	cd px-jenkins && terraform init

rancher-plan: init
	cd px-rancher
	terraform plan

jenkins-plan: init
	cd px-jenkins
	terraform plan
	
rancher: rancher-plan
	cd px-rancher
	terraform apply

jenkins: jenkins-plan
	cd px-jenkins 
	terraform apply