#
# Cookbook Name:: solr
# Recipe:: default
#
#
#
["openjdk-6-jdk", "libxml2", "libxml2-dev", "libxslt1-dev"].each do |pkg|
  package pkg do
    action :install
  end
end

directory "/data/jettyapps" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

directory "/var/log/solr" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

script "Install solr" do
  user "root"
  interpreter "bash"
  code <<-EOH
    if [ ! -e /data/jettyapps/solr ]; then
      cd /data/jettyapps
      wget http://apache.cs.utah.edu//lucene/solr/1.4.1/apache-solr-1.4.1.tgz
      tar -zxf apache-solr-1.4.1.tgz
      mv apache-solr-1.4.1/example solr
      rm -rf apache-solr-1.4.1
    fi
  EOH
end

gem_package "sunspot_rails" do
  action :install
end

gem_package "nokogiri" do
  action :install
end

script "Initialize Sunspot" do
  user "root"
  interpreter "bash"
  code <<-EOH
    sunspot-installer -f /data/jettyapps/solr/solr
    cd /data/jettyapps/solr
    nohup java -Djava.net.preferIPv4Stack=true -Dsolr.solr.home=solr -jar start.jar >> /var/log/solr/solr.log &
    nohup java -Djetty.port=8984 -Dsolr.data.dir=solr/data/test -jar start.jar >> /var/log/solr/solr.log &
  EOH
end
