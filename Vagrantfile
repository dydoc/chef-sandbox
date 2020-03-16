# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'ipaddr'
require 'yaml'
conf = YAML.load(File.read("conf.yaml"))
#puts "Config: #{conf.inspect}\n\n"

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

  conf['group'].each do | group, group_properties |
    (1..group_properties.fetch('cardinality')).each do |i|
      hostname = "#{group}-%02d" % i
      config.vm.define hostname % i do |server|
        server.vm.box= group_properties.fetch('box_name')
        server.vm.hostname = hostname
        server.vm.provider :virtualbox do |v|
        #  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          v.cpus = group_properties.fetch('cpus')
          v.memory = group_properties.fetch('memory')*1024
          v.name = hostname
        end       
      end
    end
  end
end