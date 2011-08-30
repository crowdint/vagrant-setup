Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  config.vm.network "33.33.33.10"

  config.vm.provision :chef_solo do |chef|
     chef.cookbooks_path = "cookbooks"

     chef.add_recipe "general"
     chef.add_recipe "postgresql"
     chef.add_recipe "redis"
     # chef.add_recipe "mysql"
     # chef.add_recipe "solr"
     # chef.add_recipe "mongodb"
  end

  config.vm.customize do |vm|
    vm.memory_size = 1024
  end
end