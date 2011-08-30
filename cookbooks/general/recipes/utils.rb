#
# Cookbook Name:: general
# Recipe:: utils
#

package "htop" do
  action :install
end

file "/etc/profile.d/vibash.sh" do
  action :create
  owner "root"
  group "root"
  content "set -o vi"
end
