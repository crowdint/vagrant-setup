MONGODB_VERSION="1.8.3"

script "Install MongoDB" do
  user "root"
  interpreter "bash"
  code <<-EOH
    if [ ! -e /sbin/mongod ]; then
      cd /usr/local
      wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{MONGODB_VERSION}.tgz
      tar -zxf mongodb-linux-x86_64-#{MONGODB_VERSION}.tgz
      mv mongodb-linux-x86_64-#{MONGODB_VERSION}/bin/mongod /sbin
      rm -rf mongodb-linux-x86_64-#{MONGODB_VERSION}
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
