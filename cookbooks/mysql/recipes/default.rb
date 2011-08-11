#
# Cookbook Name:: mysql
# Recipe:: default
#
#
package "mysql-server" do
  action :install
end

template "/etc/mysql/my.cnf" do
  source "my.cnf.erb"
  action :create
  owner "root"
  group "root"
  mode "644"
end

script "mysql privileges" do
  interpreter "bash"
  user "root"
  code <<-EOH
    mysql -uroot -e "GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES"
  EOH
end
