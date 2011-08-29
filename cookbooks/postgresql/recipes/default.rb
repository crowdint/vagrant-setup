#
# Cookbook Name:: postgresql
# Recipe:: default
#

script "Updating apt-get" do
  interpreter "bash"
  user "root"
  code <<-EOH
    apt-get update
  EOH
end

# Install postgres 8.4, and the comunity extras
%w{ postgresql postgresql-contrib }.each do | name |
  package name do
    action :install
  end
end

script "Adding PostgreSQL paths" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if cat /etc/bash.bashrc | grep 'PGDATA' > /dev/null; then
      echo 'PostgreSQL paths ready in /etc/bash.bashrc'
    else
      echo 'Adding PostgreSQL paths to /etc/bash.bashrc'
      echo '# PostgreSQL'                                   >> /etc/bash.bashrc;
      echo 'export PATH=$PATH:/usr/lib/postgresql/8.4/bin/' >> /etc/bash.bashrc;
      echo 'export PGDATA=/usr/local/pgsql/data'            >> /etc/bash.bashrc;
    fi
  EOH
end

# Setup PostgreSQL dir
directory "/usr/local/pgsql/data" do
  owner "postgres"
  group "postgres"
  mode 0755
  recursive true
end

script "Setup PostgreSQL structure" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if [ ! -e /usr/local/pgsql/data/base ]; then
      echo "Creating PostgreSQL data directory."
      su postgres -p -c "initdb -D /usr/local/pgsql/data"
    else
      echo "PostgreSQL data-dir ready."
    fi
  EOH
end

# Updating the configuration files
template "/usr/local/pgsql/data/postgres.conf" do
  source "postgres.conf"
  action :create
  owner "root"
  group "root"
  mode "644"
end

template "/usr/local/pgsql/data/pg_hba.conf" do
  source "pg_hba.conf"
  action :create
  owner "root"
  group "root"
  mode "644"
end

script "Start PostgreSQL server" do
  user "postgres"
  interpreter "bash"
  code <<-EOH
    nohup postgres &
  EOH
end
