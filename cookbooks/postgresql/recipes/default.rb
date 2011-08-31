#
# Cookbook Name:: postgresql
# Recipe:: default
#

CONFIG='/etc/postgresql/8.4/main'
DATA='/var/lib/postgresql/8.4/main'
README='/home/vagrant/postgresql-readme.txt'

# Install postgres 8.4, and the comunity extras
%w{ postgresql postgresql-contrib }.each do | name |
  package name do
    action :install
  end
end

# Updating the configuration files
template "#{CONFIG}/postgresql.conf" do
  source "postgresql.conf"
  action :create
  owner "postgres"
  group "postgres"
  mode "644"
end

template "#{CONFIG}/pg_hba.conf" do
  source "pg_hba.conf"
  action :create
  owner "postgres"
  group "postgres"
  mode "644"
end

template "/var/lib/postgresql/fix-locales.sql" do
  source "fix-locales.sql"
  action :create
  owner "postgres"
  group "postgres"
  mode "644"
end

script "Setup PostgreSQL" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if cat #{README} | grep 'db user' > /dev/null; then
      echo 'PostgreSQL users are ready at #{README}.'
    else
      service postgresql-8.4 restart
      sudo -H -u postgres psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'p0stgres'"

      echo '- db host: 33.33.33.10'       >> #{README}
      echo '- db port: 5432'              >> #{README}
      echo '- db user: postgres:p0stgres' >> #{README}
      echo 'Config: #{CONFIG}'            >> #{README}
      echo 'Data: #{DATA}'                >> #{README}
    fi
  EOH
end

script "Fix locales" do
  interpreter "bash"
  user "postgres"
  code "psql -f /var/lib/postgresql/fix-locales.sql"
end
