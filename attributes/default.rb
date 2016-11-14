#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

default['mconf-db']['database']['install'] = true
default['mconf-db']['passwords']['root'] = 'password'
default['mconf-db']['databases'] = []
# Example:
# default['mconf-db']['databases'] = [
#   {
#     'name' => 'mconf_production', # First database
#     'user' => 'mconf',
#     'password' => 'password',
#     'hosts' => ['%'],
#     'socket' => '/var/run/mysql-default/mysqld.sock'
#   },
#   {
#     'name' => 'mconf_test', # second database
#     'user' => 'mconf',
#     'password' => 'password',
#     'hosts' => ['%'],
#     'socket' => '/var/run/mysql-default/mysqld.sock'
#   }
# ]


# Redis
default['mconf-db']['redis']['install'] = true
default['mconf-db']['redis']['logfile'] = "/var/log/redis.log"
default['mconf-db']['redis']['databases'] = 16
default['mconf-db']['redis']['instances'] = [
  { "name" => "master",
    "port" => 6379,
    "logfile" => "/var/log/redismaster.log"
  }
]
# Set address(es) to bind to. Set 127.0.0.1 to protect from external access.
# Defaults to nil, which will make redis bind to all available interfaces.
# default['mconf-db']['redis']['address'] = "127.0.0.1"

# On linux you can get a good password with `pwgen -s 64 1`
# (just make sure you remove any quotes or double quotes from it)
# default['mconf-db']['redis']['instances'][0]['requirepass'] = 'use-a-long-password-hard-to-brute-force'

# Ruby (for mysql2_chef_gem). If the version is set to nil ruby will not be installed.
default['mconf-db']['ruby']['version'] = "2.3"
default['mconf-db']['ruby']['packages'] = [
  "ruby#{node['mconf-db']['ruby']['version']}",
  "ruby#{node['mconf-db']['ruby']['version']}-dev"
]
