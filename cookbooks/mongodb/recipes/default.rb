#
# Cookbook Name:: mongod
# Recipe:: default
#

DOWNLOAD="http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-1.8.3.tgz"
README='/home/vagrant/mongod-readme.txt'

script "Install MongoDB" do
  user "root"
  interpreter "bash"
  code <<-EOH

    if cat #{README} | grep 'host' > /dev/null; then
      echo 'MongoDB ready, see more at #{README}.'
    else
      wget -O mongo.tgz #{DOWNLOAD};
      tar -zxf mongo.tgz;
      mv ./mongodb* ./mongo;
      mv ./mongo/bin/mongod /usr/local/sbin;
      mv ./mongo/bin/mongo /usr/local/bin;
      rm -rf ./mongo*;

      echo '- host: 33.33.33.10'        >> #{README}
      echo '- port: 27017 (db)'         >> #{README}
      echo '- port: 28017 (web admin)'  >> #{README}
    fi
  EOH
end

directory '/data/db' do
  owner "root"
  group "root"
  mode 0755
  action :create
  recursive true
end

script "Start the MongoDB service" do
  user "root"
  interpreter "bash"
  code <<-EOH
    nohup /sbin/mongod >> /var/log/mongodb.log &
  EOH
end
