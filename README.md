[![Build Status](https://travis-ci.org/GeoffWilliams/name_service_switch.svg?branch=master)](https://travis-ci.org/GeoffWilliams/name_service_switch)
# name_service_switch

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Manage the name service switch - `/etc/nsswitch.conf` on Linux and Solaris, `/etc/netsvc.conf` on AIX

## Setup

### What name_service_switch affects
* Manage entries in  `/etc/nsswitch.conf` or `/etc/netsvc.conf` file depending on OS
* Takes ownership of existing entries based on `file_line` match patterns, does not rewrite the entire file
* Restarts the dns-client on Solaris

## Usage

### Basic

```puppet
include name_service_switch
```

Simplest usage, just sets the `hosts:` entry to `files dns`.

### Custom

```puppet
class { "name_service_switch":
    entries => {
      "hosts" => "files dns myhostname",
      "bar"   => "foo baz"
    }
}
```

Ensures that `hosts` line is set to `files dns myhostname` and the `bar` line is set to `foo baz`.  If `bar` doesn't exist, it will be added to the file.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

* Assumes that cron itself is already installed
* Does not attempt to manage the cron services
* Not supported by Puppet, Inc.

## Development

PRs accepted :)

## Testing
This module supports testing using [PDQTest](https://github.com/GeoffWilliams/pdqtest).


Test can be executed with:

```
bundle install
bundle exec pdqtest all
```


See `.travis.yml` for a working CI example
