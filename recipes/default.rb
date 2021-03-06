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

if node['mconf-db']['database']['install']
  include_recipe "mconf-db::database"
end

if node['mconf-db']['redis']['install']
  include_recipe "mconf-db::redis"
end
