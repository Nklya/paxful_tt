# Tesk task

## Initial description

Using the automation tools of your choice prepare a FULLY provisioned cloud environment in AWS.

This automation should do:

* Deploy 3 EC2 nodes (App, DB Master (PostgreSQL), DB Slave (PostgreSQL) based on last stable Debian
* Setup Nginx+php-fpm on App VM and deploy PHP code that will respond to the URL like 'http://_host_/?n=x', where 'x' is number. This request should return Fibonacci ’n’ numbers starting from 0.
* Setup master-slave (replication) PostgreSQL between node 2 and 3.
* Prepare a solution that adds a special URL path “/blacklisted” with requirements:
  * return error code 444 to visitor
  * block the IP of visitor
  * send an email with IP address to "test@domain.com"
  * insert into PostgreSQL table information: path, ip address of the visitor and datetime when he got blocked

## How to start

1. Clone repository
2. Check that you have installed:
    * Terraform (0.11)
    * Ansible (>2.7)
    * Vagrant + Virtualbox
    * InSpec
3. Execute `make prepare` to generate ssh keys and terraform.tfvars
4. Fill your AWS keys in terraform.tfvars
5. Execute `make aws` to create and provision infrastracture in AWS + tests
6. Execute `make aws-destroy` to delete infrastracture in AWS
7. Execute `make vagrant` to create and provision infrastracture in Vagrant + tests
8. Execute `make vagrant-destroy` to delete infrastracture in Vagrant

## Structure

* Makefile - wrapper for all actions
* ansible - directory with ansible code and Vagrantfile to provision instances
* ansible/roles/app_deploy - role, which deploy php code from `file` folder, setup credentials, and mail delivery
* ansible/roles/nginx - role, which install and configure nginx
* ansible/roles/php_fpm - role, which install and configure php-fpm
* ansible/roles/pgsql_ms - role, which install and configure PostgreSQL and replication
* terraform - directory with terraform code to create infrastracture in AWS

```text
├── Makefile
├── README.md
├── ansible
│   ├── Vagrantfile
│   ├── ansible.cfg
│   ├── app.yml
│   ├── db.yml
│   ├── deploy.yml
│   ├── environments
│   │   ├── aws
│   │   └── vagrant
│   ├── roles
│   │   ├── app_deploy
│   │   ├── nginx
│   │   ├── pgsql_ms
│   │   └── php_fpm
│   ├── site.yml
│   └── vault.key
└── terraform
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfvars.example
    ├── variables.tf
    └── vpc.tf
```

## Tests

1. There is `Vagrantfile` in ansible directory so you can create and provision all infrastracture locally.
2. For role `ansible/roles/nginx` created molecule+testinfra config.
3. In `tests/vagrant` and `tests/aws` stored InSpec test profiles.
4. When you run `make vagrant` or `make aws`, they run after creation and provision.

## How it works

* PHP applications are stored at `ansible/roles/app_deploy/files`
* The first one `ansible/roles/app_deploy/files/index.php` - respond to the URL like 'http://_host_/?n=x', where 'x' is number. This request returns Fibonacci ’n’ numbers starting from 0.
* The second one `ansible/roles/app_deploy/files/blacklisted/index.php`
  * return error code 444 to visitor
  * block the IP of visitor (through nginx `deny` option)
  * send an email with IP address to "root@localhost" (through local exim)
  * insert into PostgreSQL table information: path, ip address of the visitor and datetime when he got blocked (user, password and database name can be defined in variables)
* Ansible role `ansible/roles/app_deploy` deploys them and configure Database, e-mail and other things.

P.S. To check local email, execute `mail -f /var/mail/mail` or `mail -f /var/mail/vagrant` (for Vagrant)

## TODO (ideas to improve current solution)

* Terraform:
  * split code into modules
  * use remote state in S3
* Ansible:
  * remove vault.key from repo
  * add tags inside roles
  * place app to separate repository
* Tests:
  * Add inspec aws specific tests
  * molecule for all roles
