# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
conf = YAML.load(File.read("conf.yaml"))


Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"


  ### folder settings ###
  conf['synced_folders'].each do | synced_folder_name, synced_folder_value |
    src = synced_folder_value['src']
    dst = synced_folder_value['dst']
    technology = synced_folder_value['technology']
    config.vm.synced_folder src, dst, type: technology
  end

  ### network settings ####

  config.vm.network "private_network", type: "dhcp"
  config.ssh.forward_agent= true
  conf['forwarded_ports'].each do | application_name, forwarded_port_value |
       internal_port = forwarded_port_value['internal_port']
       external_port = forwarded_port_value['external_port']
       config.vm.network "forwarded_port", guest: internal_port, host: external_port
  end

  # provision section
  config.vm.provision "shell", path: "install_chef.sh"
  config.vm.provision "file", source: "bashrc.d", destination: "~/.bashrc.d"
  config.vm.provision "shell", path: "configure_chef.sh", privileged: false , args: "~/.bashrc"

  $script = <<-SCRIPT
  sudo apt-get install -y git
  SCRIPT
  
  config.vm.provision "shell", inline: $script



end
