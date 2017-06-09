# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definición del despliegue 

# Numero de instancias
INSTANCES=2

DOMAIN="cfv.junta-andalucia.es"

MEMORY=1024

# the instances is a hostonly network, this will
# be the prefix to the subnet they use
SUBNET="192.168.1"

VAGRANTFILE_API_VERSION = "2"

$set_puppet_version = <<EOF
 subscription-manager register --username miguel.angel.falc0n --password q2w3e4r5t6 --auto-attach
 /bin/rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
 /usr/bin/yum clean all
 /usr/bin/yum makecache
 /usr/bin/yum -y erase puppet
 /usr/bin/yum -y install puppet
# /usr/bin/yum -y install redhat-lsb
EOF


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://proxy.cfv.junta-andalucia.es:3128"
    config.proxy.https    = "http://proxy.cfv.junta-andalucia.es:3128"
    config.proxy.no_proxy = "localhost,127.0.0.1,.junta-andalucia.es"
  end

  config.vm.synced_folder"C:\\vagrant\\Entornos\\inope_greg", "/vagrant"

  config.vm.define :middleware do |vmconfig|
    config.vm.box = "plrh7.3"
    vmconfig.vm.network :private_network, ip: "#{SUBNET}.10"
    vmconfig.vm.hostname = "vmmysql01.#{DOMAIN}"
    vmconfig.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", MEMORY]
    end
    vmconfig.vm.box = "plrh7.3"
    vmconfig.vm.provision :shell, :inline => $set_puppet_version
    vmconfig.vm.provision :puppet, :options => ["--pluginsync --hiera_config /vagrant/deploy/hiera.yaml"], :module_path => "deploy/modules", :facter => { "middleware_ip" => "#{SUBNET}.10" } do |puppet|
      puppet.options = "--verbose --debug"
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end
end
