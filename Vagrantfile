Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.network :hostonly, "33.33.33.10"
  # config.vm.network :bridged

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("general")
    chef.add_recipe("general::utils")
    chef.add_recipe("testbot")
  end
end
