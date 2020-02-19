# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
conf = YAML.load(File.read("conf.yaml"))

def set_sharing_folder_protocol
  if Vagrant::Util::Platform.windows? then
    technology = 'smb'
  end
  if Vagrant::Util::Platform.linux? then
    technology = 'nfs'
  end
  if Vagrant::Util::Platform.darwin? then
    technology = 'nfs'
  end  
  puts technology
  return technology
end

def set_mount_option
  if Vagrant::Util::Platform.windows? then
    option = ["vers=2.1"]
  end
  if Vagrant::Util::Platform.linux? then
    option = []
  end
  if Vagrant::Util::Platform.darwin? then
    option = []
  end  
  puts option
  return option
end



Vagrant.configure("2") do |config|

  config.vm.box = conf['vagrant_box']
  config.vm.box_version = conf['vagrant_box_version']



  ### folder settings ###

  conf['synced_folders'].each do | synced_folder_name, synced_folder_value |
    src = synced_folder_value['src']
    dst = synced_folder_value['dst']
    config.vm.synced_folder src, dst, type: set_sharing_folder_protocol(), mount_options: set_mount_option()
  end




  ### network settings ####

  config.vm.network "private_network", type: "dhcp"
  config.ssh.forward_agent = true
  conf['forwarded_ports'].each do | application_name, forwarded_port_value |
       internal_port = forwarded_port_value['internal_port']
       external_port = forwarded_port_value['external_port']
       config.vm.network "forwarded_port", guest: internal_port, host: external_port
  end



  # provision section

  $script = <<-SCRIPT
  sudo apt-get install -y git unzip 
  SCRIPT
  
  config.vm.provision "shell", inline: $script
 
  #configure bashrc.d seletcing what you need
  config.vm.provision "shell", path: "configure_bashrcd.sh", privileged: false , args: "~/.bashrc"

  if conf['bashrcd'].nil? then
    puts "nothing to add to bashrc.d"
  else
    conf['bashrcd'].each do | name, filename |
      source_filename = "bashrc.d/" + filename['source_file']
      destination_filename = "~/" + "bashrc.d/" + name + ".bash"
      config.vm.provision "file", source: source_filename, destination: destination_filename
    end  
  end



  config.vm.provider conf['hypervisor'] do |v|
    v.memory = conf['machine']['memory']
    v.cpus = conf['machine']['cpu']
  end


end
