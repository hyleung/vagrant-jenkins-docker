#Vagrant + Jenkins + Docker

This is a Vagrant-based setup for Jenkins w/Docker build agents. Uses Puppet to provision the necessary bits and pieces for the Jenkins build master. 

##Pre-requisites

- [Vagrant](http://www.vagrantup.com)
- [Librarian Puppet](https://github.com/rodjek/librarian-puppet) for installing the necessary Puppet modules
- Either VMWare or VirtualBox, for local environments
- [Optional] Vagrant [AWS plugin](https://github.com/mitchellh/vagrant-aws) for AWS environments

##Local Setup

With Vagrant and Librarian Puppet installed, first install the necessary Puppet modules

    librarian-puppet install

To bring up your local environment with your default provider:

    vagrant up 

Or, with an alternate provider (e.g. virtualbox)

    vagrant up --provider=virtualbox

##AWS Setup

This repo includes a branch, `feat/aws`, that has a modified Vagrantfile that can be used to provision to EC2. 

For provisioning to AWS, you'll need:

- an AWS account
- a set of AWS credentials - typically you'll set up a user in IAM and generate a set of access keys. 
- a key pair for securing access to the EC2 instance

###Environment variables

The Vagrantfile is set up to grab some necessary information from environment variables. In particular:

- `AWS_ACCESS_KEY` -> your AWS access key
- `AWS_SECRET_KEY` -> your AWS secret
- `AWS_REGION` -> the desired AWS region
- `AWS_KEYPAIR` -> the keypair to be used when securing access to the instance
- `AWS_SSH_KEYPATH` -> the path to the pem file that corresponds to the keypair

There is a file included in the `feat/aws` branch that can be used to set your environment variables. Make a copy and update it with your keys, etc. You can `source` this into your shell.

### **DO NOT** check this file in, especially to a publicly accessible repository - it contains your AWS access keys.

Once you have your environment variables all set up, you can then bring up your EC2 environment:

    vagrant up --provider=aws

##Tearing down your environment

Execute:

    vagrant destroy


