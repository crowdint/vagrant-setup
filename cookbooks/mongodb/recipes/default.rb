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
      echo 'MongoDB ready, #{README}.'
    else
      cd /usr/local;
      curl #{DOWNLOAD} | tar -zxf;
      mv ./mongo* ./mongo;
      mv ./mongo/bin/mongod /sbin;
      mv ./mongo/bin/mongo /bin;
      rm -rf ./mongo;

      echo '- host: 33.33.33.10'  >> #{README}
      echo '- port: 27017'        >> #{README}
      echo '- port: 28017'        >> #{README}
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

script "Start the mongo service" do
  user "root"
  interpreter "bash"
  code <<-EOH
    nohup /sbin/mongod >> /var/log/mongodb.log &
  EOH
end
