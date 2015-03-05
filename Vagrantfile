# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/debian-7.6"

  config.vm.network "forwarded_port", guest: 80, host: 1080
  config.vm.network "forwarded_port", guest: 1488, host: 1488

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "forwarded_port", guest: 4001, host: 4001
  config.vm.network "forwarded_port", guest: 4002, host: 4002
  config.vm.network "forwarded_port", guest: 4003, host: 4003
  config.vm.network "forwarded_port", guest: 4004, host: 4004
  config.vm.network "forwarded_port", guest: 4005, host: 4005

  config.vm.network "forwarded_port", guest: 5432, host: 5433

  config.vm.network "forwarded_port", guest: 6370, host: 6370
  config.vm.network "forwarded_port", guest: 6371, host: 6371
  config.vm.network "forwarded_port", guest: 6372, host: 6372
  config.vm.network "forwarded_port", guest: 6379, host: 6379

  config.vm.network "forwarded_port", guest: 7000, host: 7000
  config.vm.network "forwarded_port", guest: 7001, host: 7001
  config.vm.network "forwarded_port", guest: 7002, host: 7002
  config.vm.network "forwarded_port", guest: 7003, host: 7003
  config.vm.network "forwarded_port", guest: 7004, host: 7004
  config.vm.network "forwarded_port", guest: 7005, host: 7005

  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8001, host: 8001
  config.vm.network "forwarded_port", guest: 8002, host: 8002
  config.vm.network "forwarded_port", guest: 8003, host: 8003
  config.vm.network "forwarded_port", guest: 8004, host: 8004
  config.vm.network "forwarded_port", guest: 8005, host: 8005
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 8240, host: 8240
  config.vm.network "forwarded_port", guest: 8243, host: 8243
  
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "forwarded_port", guest: 9001, host: 9001
  config.vm.network "forwarded_port", guest: 9002, host: 9002
  config.vm.network "forwarded_port", guest: 9003, host: 9003
  config.vm.network "forwarded_port", guest: 9004, host: 9004
  config.vm.network "forwarded_port", guest: 9005, host: 9005

  config.vm.network "forwarded_port", guest: 27017, host: 27017
end
