# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :hostonly, "192.168.19.97"
  config.vm.host_name = "ckan.lo"
  config.vm.share_folder "v-root", "/vagrant", ".", :nfs => true
  config.vm.provision :shell, :path => "vagrant/provision.sh"
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  config.vm.customize ["modifyvm", :id, "--cpus", 1]
  config.ssh.forward_agent = true
  config.vm.forward_port 5000, 5000
end
