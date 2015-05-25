#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

default['mconf-db']['passwords']['root'] = 'password'
default['mconf-db']['databases'] = []

# Database for mconf-web
default['mconf-db']['databases'].push(
  'name' => 'mconf_production',
  'user' => 'mconf',
  'password' => 'password',
  'hosts' => ['%']
)

# Database for mconf-lb
default['mconf-db']['databases'].push(
  'name' => 'mconf_lb_production',
  'user' => 'mconf',
  'password' => 'password',
  'hosts' => ['%']
)
