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

include_recipe "apt"
include_recipe 'build-essential'
package 'git'

mysql_name = 'default'
mysql_service mysql_name do
  version node['mconf-db']['mysql']['version']
  port '3306'
  bind_address '0.0.0.0'
  initial_root_password node['mconf-db']['passwords']['root']
  mysqld_options node['mconf-db']['mysql']['mysqld_options']
  action [:create, :start]
end

# install ruby because we need it for mysql2_chef_gem and mysql_database_user
# installs globally but it's not added to the PATH automatically
if node['mconf-db']['ruby']['packages']
  apt_repository 'ruby-ng' do
    uri 'ppa:brightbox/ruby-ng'
    components ['main']
  end
  node['mconf-db']['ruby']['packages'].each do |name|
    package name
  end
end

# mysql_database_user needs this
mysql2_chef_gem 'default' do
  action :install
end

node.override['mconf-db']['databases'] = [node['mconf-db']['databases']] unless node['mconf-db']['databases'].is_a?(Array)
node['mconf-db']['databases'].each do |db|
  connection_info = {
    host: 'localhost',
    username: 'root',
    password: node['mconf-db']['passwords']['root'],
    socket: "/var/run/mysql-#{mysql_name}/mysqld.sock"
  }

  # create the user
  # TODO: if the same user is used in multiple databases, it is overriding the password
  # with the last one specified
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

  # give the user permission when on external hosts
  if db['hosts'] && db['hosts'].length > 0
    db['hosts'].each do |host_info|
      mysql_database_user db['user'] do
        connection connection_info
        database_name db['name']
        host host_info
        action :grant
      end
    end
  end
end
