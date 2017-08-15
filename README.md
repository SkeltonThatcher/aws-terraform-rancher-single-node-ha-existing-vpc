# Single Node SSL/HA for Rancher Server and GoCD in AWS

This repo contains Terraform code with supporting scripts and advisories to deploy single node HA Rancher server and Rancher hosts in AWS, with supporting EC2 security groups in place for the following custom catalog items:

* GoCD server and GoCD auto-registered agents
* Splunk Enterprise Monitor
* SonarQube.

The deployment is designed for use with STCL-TECH services from the [SkeltonThatcher Rancher Build Engineering custom catalog ](https://github.com/SkeltonThatcher/rancher-buildeng-catalog)

The Terraform plan is designed to be deployed to existing VPC & subnet infrastructure and will build out and deploy the following resources.

* RDS DB subnet group
* Single-AZ or Multi-AZ RDS MySQL DB instance
* SSL enabled elastic load balancer + listeners
* Launch configuration + fixed Multi-AZ auto-scaling group of x1 instance for the Rancher server
* Launch configuration + fixed Multi-AZ auto-scaling group of a specified EC2 instance amount for the Rancher hosts
* EC2 IAM policy role for the Rancher server & hosts, granting full access to EC2, S3, Route 53, SNS & Cloudwatch
* RancherOS EC2 instance with active Docker running a password protected deployment of Rancher server
* RancherOS EC2 instances with active Docker as Rancher hosts
* Route 53 DNS alias record for the ELB

The estimated deployment time is 30 minutes.

### Prerequisites

* AWS account
* AWS IAM user account with AWS access/secret keys and permission to create specified resources
* Existing AWS VPC and subnets (public x2 + private x2)
* Valid SSL certificate present in the AWS Certificate Manager
* Cygwin (or similar) installed to enable running of .sh scripts if using Windows
* Git installed and configured
* Terraform installed and configured

### How to use the Terraform plan to deploy AWS infrastructure supporting Rancher server and Rancher hosts

#### Version advisories
Tested with the following versions.

* RancherOS v1.0.3
* Rancher server v1.6.7
* Rancher agent v1.2.5
* Terraform 0.10.0

### Licence

Copyright (c) 2017 Skelton Thatcher Consulting Ltd.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

### Acknowledgments

* set_access_control.sh script created by [George Cairns](https://www.linkedin.com/in/george-cairns-9624b621/) from [Automation Logic](http://www.automationlogic.com/)
