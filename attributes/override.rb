#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

override['build-essential']['compile_time'] = false

settings = {}
settings['databases'] = node['mconf-db']['redis']['databases'] if node['mconf-db']['redis']['databases']
settings['logfile']   = node['mconf-db']['redis']['logfile'] if node['mconf-db']['redis']['logfile']
settings['address']   = node['mconf-db']['redis']['address'] if node['mconf-db']['redis']['address']
override['redisio']['default_settings'] = settings

override['redisio']['servers'] = node['mconf-db']['redis']['instances']

# rbenv + ruby
# these attributes are used by the rbenv cookbook
override['rbenv']['rubies'] = [node['mconf-db']['ruby']['version']]
