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

  config.ssh.forward_agent = true


  conf['group'].each do | group, group_properties |
    first_server_ip = IPAddr.new(group_properties.fetch('network').fetch('first_ip'))
    network_type = group_properties.fetch('network').fetch('type')
    (1..group_properties.fetch('cardinality')).each do |i|
      hostname = "#{group}-%02d" % i
      ipaddr = IPAddr.new(first_server_ip.to_i + i - 1, Socket::AF_INET).to_s
      config.vm.define hostname % i do |server|
        server.vm.box = group_properties.fetch('box_name')
        server.vm.hostname = hostname
        server.vm.network network_type, ip: ipaddr
        server.vm.provider :virtualbox do |v|
          v.cpus = group_properties.fetch('cpus')
          v.memory = (group_properties.fetch('memory').to_f*1024).to_i
          v.name = hostname
        end 
        unless group_properties['forwarded_ports'].nil?
          group_properties['forwarded_ports'].each do | application_name, forwarded_port_value |
              internal_port = forwarded_port_value['internal_port']
              external_port = forwarded_port_value['external_port']
              server.vm.network "forwarded_port", guest: internal_port, host: external_port, auto_correct: true
          end
        end
        unless group_properties['synced_folders'].nil?
          group_properties['synced_folders'].each do | synced_folder_name, synced_folder_value |
            src = synced_folder_value['src']
            dst = synced_folder_value['dst']
            server.vm.synced_folder src, dst, type: set_sharing_folder_protocol(), mount_options: set_mount_option()
          end
        end               
      end
    end
  end
end