# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "aws_dummy"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    config.vm.provider :aws do |aws,override|
        aws.ami = "ami-ddaed3ed"
        aws.region = ENV["AWS_REGION"]
        aws.instance_type = "t1.micro"
        aws.keypair_name = ENV["AWS_KEYPAIR"]
        aws.user_data = File.read("files/user-data-script.sh")
        override.ssh.username = "ubuntu"
        override.ssh.private_key_path = ENV["AWS_SSH_KEYPATH"]
    end
	config.vm.provision :puppet do |puppet|
        puppet.module_path = "modules"
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "base.pp"
        puppet.options = "--hiera_config /vagrant/files/hiera.yaml"
	end
	#config.vm.provision "docker" do |d|
	#		  d.pull_images "evarga/jenkins-slave"
	#end
end

