mconf-db Cookbook
==================

This Chef cookbook installs the database server used by Mconf.

It installs and configures:

* MySQL, with one or more databases.
* Redis server.


Requirements
------------

This cookbook is tested with Chef 11 (latest version). It may work with or without modification on
newer versions of Chef, but Chef 11 is recommended.

Platform
--------

This cookbook currently supports Ubuntu 14.04. It will always be updated to support the OS version
supported by the applications that use databases on Mconf (e.g. Mconf-Web), which is usually the
latest LTS version of Ubuntu.

Recipes
-------

#### default

Installs the database server, including:

* Installs MySQL;
* Creates databases in MySQL as specified, setting access permissions;
* Installs redis server;

#### client

Installs MySQL client only, usually installed alongside servers that need MySQL client,
usually for testing/debugging purposes (accessing MySQL's console).

#### remove

Removes MySQL and redis, the opposite of what is done by the recipe `default`.


Usage
-----

#### mconf-db::default

Include `mconf-db` in your node's `run_list` along with the recommended attributes:

```json
{
  "name": "my_node",
  "mconf-db": {
    "user": "mconf",
    "app_group": "www-data",
    "domain": "192.168.0.100",
    "passwords": {
      "root": "my-root-password"
    },
    "databases": [
      {
        "name": "mconf_lb_production",
        "user": "mconf",
        "password": "my-password",
        "hosts": ["%"],
        "socket": "/var/run/mysql-default/mysqld.sock"
      },
      {
        "name": "mconf_production",
        "user": "mconf",
        "password": "my-password",
        "hosts": ["%"],
        "socket": "/var/run/mysql-default/mysqld.sock"
      }
    ],
    "redis": {
      "install": true,
      "databases": 2,
      "instances": [
        {
          "name": "master",
          "port": 6379,
          "logfile": "/var/log/redismaster.log",
          "requirepass": "lsodia8d7aspdo0,gw@,+UH$Ud5635TGH@si,.lod90d0|1DM3.}olXlooolspa"
        }
      ]
    }
  },
  "run_list": [
    "recipe[mconf-db]"
  ]
}
```

#### mconf-db::client

Include `mconf-db::client` in your node's `run_list`, no more attributes needed:

```json
{
  "name":" my_node",
  "mconf-web": {
    "user": "mconf",
    "app_group": "www-data",
    "domain": "192.168.0.100"
  },
  "run_list": [
    "recipe[mconf-web]",
    "recipe[mconf-db::client]"
  ]
}
```

#### mconf-db::remove

Include `mconf-db::remove` in your node's `run_list`, no more attributes needed:

```json
{
  "name":" my_node",
  "mconf-web": {
    "user": "mconf",
    "app_group": "www-data",
    "domain": "192.168.0.100"
  },
  "run_list": [
    "recipe[mconf-web]",
    "recipe[mconf-db::remove]"
  ]
}
```
