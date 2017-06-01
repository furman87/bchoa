# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'bchoa-dev-box'

  config.vm.network "forwarded_port", guest: 80, host: 8081 #nginx
  config.vm.network "forwarded_port", guest: 5432, host: 15432 #postgres

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision :shell, privileged: false, path: "bootstrap-postgres.sh", keep_color: true
end
