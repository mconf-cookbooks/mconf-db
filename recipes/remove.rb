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

mysql_name = 'default'
mysql_service mysql_name do
  version '5.5'
  action [:stop, :delete]
end

mysql2_chef_gem 'default' do
  action :remove
end

file "/etc/init/mysql-#{mysql_name}.conf" do
  action :delete
end

include_recipe 'redisio'
include_recipe 'redisio::disable'
