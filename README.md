# Terraform AWS Infrastructure Module

This Terraform configuration provisions an AWS infrastructure with the following components:

	* VPC with public and two private subnets

	* Security Groups to control inbound and outbound traffic

	* Network Load Balancer (NLB) with a target group

	* Application Load Balancer (ALB) with HTTPS support and a self-signed certificate

	* EC2 Instance with automatic registration to ALB target group


Prerequisites

	* Terraform and Git installed 

	* AWS CLI configured with appropriate permissions

	* SSH key pair for accessing the EC2 instance


Usage

1. Clone the Repository

 		git clone https://github.com/syedkaliff/demo.git

 		cd terraform-aws-infra

2. Initialize Terraform

 		terraform init

3. Plan Deployment

 		terraform plan

4. Apply Configuration

 		terraform apply -auto-approve

5. Destroy Resources (Optional)

   	 	terraform destroy -auto-approve


Modules Structure

	modules/network

		Creates VPC with subnets

		Outputs VPC and subnet details

	modules/security

		Creates security groups

	modules/nlb

		Provisions NLB and ALB

		Creates target groups

		Generates self-signed SSL certificate

	modules/ec2

		Creates EC2 instance

		Automatically registers instance with ALB
 
![image](https://github.com/user-attachments/assets/e63d6fc3-d299-4c73-957a-ad5fbbc4c35b)

![image](https://github.com/user-attachments/assets/a7476a8e-3bf3-4a6b-abc0-f2cd80fa622d)

![image](https://github.com/user-attachments/assets/8c7d4cf3-1273-4cb4-b86b-6dc8c22bd54a)

![image](https://github.com/user-attachments/assets/488e2819-2470-45b5-bc0c-9ee0699a453c)



