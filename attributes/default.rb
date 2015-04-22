#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

default['db']['passwords']['root'] = 'password'

default['db']['databases'] = []

# Database for mconf-web
default['db']['databases'].push(
  'name' => 'mconf_production',
  'user' => 'mconf',
  'password' => 'password'
)

# Database for mconf-lb
default['db']['databases'].push(
  'name' => 'mconf_lb_production',
  'user' => 'mconf',
  'password' => 'password'
)
