# Name_service_switch
#
# Manage the name service switch - nsswitch.conf on linux and solaris,
# /etc/netsvc.conf on aix
class name_service_switch(
    String              $nss_owner  = $name_service_switch::params::nss_owner,
    String              $nss_path   = $name_service_switch::params::nss_path,
    String              $nss_group  = $name_service_switch::params::nss_group,
    String              $nss_mode   = $name_service_switch::params::nss_mode,
    String              $ldelim     = $name_service_switch::params::ldelim,
    String              $delim      = $name_service_switch::params::delim,
    String              $rdelim     = $name_service_switch::params::rdelim,
    Hash[String,String] $entries    = $name_service_switch::params::entries,
) inherits name_service_switch::params {

  file { $nss_path:
    ensure => file,
    owner  => $nss_owner,
    group  => $nss_group,
    mode   => $nss_mode,
  }

  $ldelim_re = $ldelim ? {
    ""      => "",
    default => "${ldelim}*",
  }

  $entries.each |$key, $value| {
    file_line { "${nss_path} ${key}":
      ensure => present,
      path   => $nss_path,
      line   => "${key}${ldelim}${delim}${rdelim}${value}",
      match  => "^${key}${ldelim_re}${delim}",
    }
  }

}
