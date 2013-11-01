# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# This Vagrantfile has been upgraded (Nov 1, 2013) for Vagrant 1.3.4
# Syntax of some commands have changed
#

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "192.168.19.97"
#  config.vm.host_name = "ckan.lo" # hostname directive failing with Vagrant.configure("2")
  config.vm.synced_folder "./", "/vagrant", id: "vagrant-root", nfs: true
  config.vm.provision :shell, :path => "vagrant/package_provision.sh"
  
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--cpus", 1]
  end
  config.ssh.forward_agent = true
end