# Tesk task for Paxful

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

##
