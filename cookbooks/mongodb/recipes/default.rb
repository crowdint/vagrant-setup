MONGODB_VERSION="1.8.3"

script "Install MongoDB" do
  user "root"
  interpreter "bash"
  code <<-EOH
    if [ ! -e /sbin/mongod ]; then
      cd /usr/local
      
      if $(uname -a | grep 'x86_64'); then
        ARCH="x86_64"
      else
        ARCH="i686"
      fi
      
      wget http://fastdl.mongodb.org/linux/mongodb-linux-$ARCH-#{MONGODB_VERSION}.tgz
      tar -zxf mongodb-linux-$ARCH-#{MONGODB_VERSION}.tgz
      mv mongodb-linux-$ARCH-#{MONGODB_VERSION}/bin/mongod /sbin
      rm -rf mongodb-linux-$ARCH-#{MONGODB_VERSION}
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
