#
# Cookbook Name:: general
# Recipe:: default
#
#
script "Update ubuntu packages" do
  interpreter "bash"
  user "root"
  code <<-EOH
    apt-get update
  EOH
end

package "htop" do
  action :install
end

file "/etc/profile.d/vibash.sh" do
  action :create
  owner "root"
  group "root"
  content "set -o vi"
end
