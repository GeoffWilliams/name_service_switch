# Name_service_switch
#
# Manage the name service switch - Manage the name service switch -
# `/etc/nsswitch.conf` on Linux and Solaris, `/etc/netsvc.conf` on AIX
#
# The different supported platforms have different ways of assigning values in
# their respective configuration files.  For example, solaris uses:
# `:\tVALUE`
# Whereas AIX uses:
# ` = `
# In the examples above, up-to three characters are used to delimit a key vs a
# value.  Taking AIX, ldelim is ``, delim is `` and rdelim is ``.
#
# The module largely takes care of these idiosyncrasies itself, however, you may
# override via parameters if necessary
#
# @param nss_owner File owner for files managed
# @param nss_path Path to file containing name service switch information
# @param nss_group File group for files managed
# @param nss_mode File mode for files managed
# @param ldelim Left delimiter between a key and a value
# @param delim Central delimiter between a key and a value
# @param rdelim Right delimiter between a key and a value
# @param entries Hash of key value pairs to add to the name service switch file.
#   If entries already exist they will be edited to show the values in this hash.
#   The keyname is the the switch you are changing, eg `hosts` and the value is
#   the desired new setting, eg `files dns`
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
