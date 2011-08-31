#
# Cookbook Name:: redis
# Recipe:: default
#

CONFIG='/etc/redis'
README='/home/vagrant/redis-readme.txt'

# Install redis-server
%w{ redis-server }.each do | name |
  package name do
    action :install
  end
end

# Updating the configuration files
template "#{CONFIG}/redis.conf" do
  source "redis.conf"
  action :create
  owner "root"
  group "root"
  mode "644"
end

script "Setup Redis" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if cat #{README} | grep 'host' > /dev/null; then
      echo 'Redis users are ready at #{README}.'
    else
      service postgresql-8.4 restart;
      echo '- host: 33.33.33.10'       >> #{README}
      echo '- port: 6379'              >> #{README}
    fi
  EOH
end