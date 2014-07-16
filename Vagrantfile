# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "trusty64_docker"
    config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box" 
	config.vm.network "forwarded_port", guest:8080, host: 9090
	config.vm.network "forwarded_port", guest:4243, host: 4243
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

