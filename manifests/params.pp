# == Class: vim::params
#
class vim::params {
  $package_name = $::osfamily ? {
    default => 'vim',
  }

  $package_list = $::osfamily ? {
    default => undef,
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/vim',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/vim/vimrc',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_require = $::osfamily ? {
    default => 'Package[vim]',
  }

  case $::osfamily {
    'Debian': {
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
