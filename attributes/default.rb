#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

default['mconf-db']['passwords']['root'] = 'password'
default['mconf-db']['databases'] = [
  {
    'name' => 'mconf_production', # Database for mconf-web
    'user' => 'mconf',
    'password' => 'password',
    'hosts' => ['%']
  },
  {
    'name' => 'mconf_lb_production', # Database for mconf-lb
    'user' => 'mconf',
    'password' => 'password',
    'hosts' => ['%']
  }
]


# Redis
default['mconf-db']['redis']['install'] = true
default['mconf-db']['redis']['databases'] = 16
default['mconf-db']['redis']['instances'] = [
  { "name" => "master",
    "port" => 6379
  }
]

# On linux you can get a good password with `pwgen -sy 64 1`
# (just make sure you remove any quotes or double quotes from it)
# default['mconf-db']['redis']['instances'][0]['requirepass'] = 'use-a-long-password-hard-to-brute-force'
