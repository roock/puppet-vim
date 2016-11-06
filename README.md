# vim

[![Build Status](https://travis-ci.org/dhoppe/puppet-vim.png?branch=master)](https://travis-ci.org/dhoppe/puppet-vim)
[![Code Coverage](https://coveralls.io/repos/github/dhoppe/puppet-vim/badge.svg?branch=master)](https://coveralls.io/github/dhoppe/puppet-vim)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/vim.svg)](https://forge.puppetlabs.com/dhoppe/vim)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/dhoppe/vim.svg)](https://forge.puppetlabs.com/dhoppe/vim)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/dhoppe/vim.svg)](https://forge.puppetlabs.com/dhoppe/vim)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/dhoppe/vim.svg)](https://forge.puppetlabs.com/dhoppe/vim)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with vim](#setup)
    * [What vim affects](#what-vim-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vim](#beginning-with-vim)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures the Vim package.

## Module Description

This module handles installing and configuring Vim across a range of
operating systems and distributions.

## Setup

### What vim affects

* vim package.
* vim configuration file.

### Setup Requirements

* Puppet >= 3.0
* Facter >= 1.6
* [Extlib module](https://github.com/voxpupuli/puppet-extlib)
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with vim

Install vim with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'vim': }
```

Install vim with the recommended parameters.

```puppet
    class { 'vim':
      config_file_template => "vim/${::lsbdistcodename}/etc/vim/vimrc.erb",
      config_file_hash     => {
        'vimrc.local' => {
          config_file_path   => '/etc/vim/vimrc.local',
          config_file_source => 'puppet:///modules/vim/common/etc/vim/vimrc.local',
        },
      },
    }
```

## Usage

Update the vim package.

```puppet
    class { 'vim':
      package_ensure => 'latest',
    }
```

Remove the vim package.

```puppet
    class { 'vim':
      package_ensure => 'absent',
    }
```

Purge the vim package ***(All configuration files will be removed)***.

```puppet
    class { 'vim':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'vim':
      config_dir_source => "puppet:///modules/vim/${::lsbdistcodename}/etc/vim",
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration
files will be removed)***.

```puppet
    class { 'vim':
      config_dir_purge  => true,
      config_dir_source => "puppet:///modules/vim/${::lsbdistcodename}/etc/vim",
    }
```

Deploy the configuration file from source.

```puppet
    class { 'vim':
      config_file_source => "puppet:///modules/vim/${::lsbdistcodename}/etc/vim/vimrc",
    }
```

Deploy the configuration file from string.

```puppet
    class { 'vim':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'vim':
      config_file_template => "vim/${::lsbdistcodename}/etc/vim/vimrc.erb",
    }
```

Deploy the configuration file from custom template ***(Additional parameters can
be defined)***.

```puppet
    class { 'vim':
      config_file_template     => "vim/${::lsbdistcodename}/etc/vim/vimrc.erb",
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'vim':
      config_file_hash => {
        'vim.2nd.conf' => {
          config_file_path   => '/etc/vim/vim.2nd.conf',
          config_file_source => "puppet:///modules/vim/${::lsbdistcodename}/etc/vim/vim.2nd.conf",
        },
        'vim.3rd.conf' => {
          config_file_path   => '/etc/vim/vim.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'vim.4th.conf' => {
          config_file_path     => '/etc/vim/vim.4th.conf',
          config_file_template => "vim/${::lsbdistcodename}/etc/vim/vim.4th.conf.erb",
        },
      },
    }
```

## Reference

### Classes

#### Public Classes

* vim: Main class, includes all other classes.

#### Private Classes

* vim::install: Handles the packages.
* vim::config: Handles the configuration file.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present',
'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'vim'.

#### `package_list`

Determines if additional packages should be managed. Defaults to 'undef'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are
'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc/vim'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are
'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid
values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent'
and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/vim/vimrc'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0644'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'Package[vim]'.

#### `config_file_hash`

Determines which configuration files should be managed via `vim::define`.
Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `background`

Determines which color scheme for syntax highlighting should be used. Valid
values are 'dark' and 'light'. Defaults to 'dark'.

#### `default_editor`

Determines if vim should be used as default editor. Valid values are 'true'
and 'false'. Defaults to 'true'.

## Limitations

This module has been tested on:

* Debian 6/7/8
* Ubuntu 12.04/14.04/16.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question
about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a
pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-vim/graphs/contributors](https://github.com/dhoppe/puppet-vim/graphs/contributors)
