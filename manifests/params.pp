# Name_service_switch::Params
#
# Params pattern
class name_service_switch::params {

  $nss_owner = "root"

  case $facts['os']['family'] {
    "AIX": {
      $nss_path   = "/etc/netsvc.conf"
      $nss_group  = "system"
      $nss_mode   = "0664"
      $ldelim     = " "
      $delim      = "="
      $rdelim     = " "
      $entries    = {"hosts" => "local4, bind4",}

    }
    "Solaris": {
      $nss_path   = "/etc/nsswitch.conf"
      $nss_group  = "sys"
      $nss_mode   = "0644"
      $ldelim     = ""
      $delim      = ":"
      $rdelim     = "\t"
      $entries    = {
        "hosts"   => "files dns",
        "ipnodes" => "files dns",
      }
    }
    "Suse",
    "Debian",
    "RedHat": {
      $nss_path   = "/etc/nsswitch.conf"
      $nss_group  = "root"
      $nss_mode   = "0644"
      $ldelim     = ""
      $delim      = ":"
      $rdelim     = "\t"
      $entries    = {"hosts" => "files dns"}
    }
    default: {
      fail("class ${name} does not support ${facts['os']['family']}")
    }
  }

}
