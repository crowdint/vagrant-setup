#
# Cookbook Name:: redis
# Recipe:: 2_0
#

CONFIG='/etc/redis'
DOWNLOAD="http://mirror.pnl.gov/ubuntu//pool/universe/r/redis/redis-server_2.0.0~rc2-1_amd64.deb"
README='/home/vagrant/redis-readme.txt'

script "Install Redis-Server-2-0" do
  user "root"
  interpreter "bash"
  code <<-EOH

    if cat #{README} | grep 'host' > /dev/null; then
      echo 'Redis-Server ready, see more at #{README}.'
    else
      wget -O redis.deb #{DOWNLOAD};
      dpkg -i redis.deb;
      rm -rf ./redis.deb;
      echo '- host: 33.33.33.10'       >> #{README}
      echo '- port: 6379'              >> #{README}
    fi
  EOH
end


#Updating the configuration files
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
    
    service redis-server restart;
    
  EOH
end