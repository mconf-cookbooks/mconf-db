#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

override['build-essential']['compile_time'] = false

settings = {}
if node['mconf-db']['redis']['databases']
  settings['databases'] = node['mconf-db']['redis']['databases']
end
override['redisio']['default_settings'] = settings

override['redisio']['servers'] = node['mconf-db']['redis']['instances']
