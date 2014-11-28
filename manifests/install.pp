# == Class: vim::install
#
class vim::install {
  if $::vim::package_name {
    package { 'vim':
      ensure => $::vim::package_ensure,
      name   => $::vim::package_name,
    }
  }

  if $::vim::package_list {
    ensure_resource('package', $::vim::package_list, { 'ensure' => $::vim::package_ensure })
  }
}
