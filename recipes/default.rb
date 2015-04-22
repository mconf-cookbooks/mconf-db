#
# Cookbook Name:: mconf-db
# Recipe:: default
# Author:: Leonardo Crauss Daronco (<daronco@mconf.org>)
#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

include_recipe 'build-essential'

execute 'apt-get update'
package 'git'

# Install MySQL Server
mysql_service 'default' do
  version '5.5'
  port '3306'
  # bind_address '0.0.0.0'
  server_root_password node['db']['passwords']['root']
  server_repl_password node['db']['passwords']['repl']
  action :create
end
# template '/etc/mysql/conf.d/mysite.cnf' do
#   owner 'mysql'
#   owner 'mysql'
#   source 'mysite.cnf.erb'
#   notifies :restart, 'mysql_service[default]'
# end

# Configure a user and a database for our app
include_recipe 'database::mysql'

node['db']['databases'] = [node['db']['databases']] unless node['db']['databases'].is_a?(Array)
node['db']['databases'].each do |db|
  connection_info = {
    host: 'localhost',
    username: 'root',
    password: node['db']['passwords']['root']
  }

  # create the user
  mysql_database_user db['user'] do
    connection connection_info
    password db['password']
    action :create
  end

  # create the database
  mysql_database db['name'] do
    connection connection_info
    action :create
  end

  # give the user permission on the database
  mysql_database_user db['user'] do
    connection connection_info
    database_name db['name']
    privileges [:all]
    action :grant
  end
end
