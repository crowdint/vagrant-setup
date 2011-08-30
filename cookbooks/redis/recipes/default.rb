#
# Cookbook Name:: redis
# Recipe:: default
#

README='/home/vagrant/redis-readme.txt'

# Install redis-server
%w{ redis-server }.each do | name |
  package name do
    action :install
  end
end

script "Setup Redis" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if cat #{README} | grep 'host' > /dev/null; then
      echo 'Redis users are ready at #{README}.'
    else
      echo '- host: 33.33.33.10'       >> #{README}
      echo '- port: 6379'              >> #{README}
    fi
  EOH
end