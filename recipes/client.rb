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

mysql_client 'default' do
  action :create
  only_if {
    node['platform'] != 'ubuntu' ||
      Gem::Version.new(node['platform_version']) < Gem::Version.new('20.04')
  }
end

mysql_client 'default' do
  action :create
  version '8.0'
  package_name ['mysql-client-8.0', 'libmysqlclient-dev']
  only_if {
    node['platform'] == 'ubuntu' &&
      Gem::Version.new(node['platform_version']) >= Gem::Version.new('20.04')
  }
end
