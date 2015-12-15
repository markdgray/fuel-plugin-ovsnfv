# == Class: ovsdpdk::clone
#
# Responsible for downloading all relevant git repos for setting up of OVS+DPDK
#
class ovsdpdk::clone(
  $dest                    = $::ovsdpdk::params::dest,
  $ovs_dir                 = $::ovsdpdk::params::ovs_dir,
  $ovs_dpdk_dir            = $::ovsdpdk::params::ovs_dpdk_dir,
  $networking_ovs_dpdk_dir = $::ovsdpdk::params::networking_ovs_dpdk_dir,
  $ovs_git_tag             = $::ovsdpdk::params::ovs_git_tag,
  $ovs_dpdk_git_tag        = $::ovsdpdk::params::ovs_dpdk_git_tag,
  $ovs_plugin_git_tag      = $::ovsdpdk::params::ovs_plugin_git_tag,
) inherits ovsdpdk {

  file { $dest:
    ensure => directory,
    mode   => '0755',
  }

  exec { "wget dpdk":
    command => "wget http://10.20.0.2:8080/plugins/fuel-plugin-mark-0.0.1/repositories/ubuntu/dpdk.zip && unzip dpdk.zip -d $ovs_dpdk_dir",
    path   => "/usr/bin:/usr/sbin:/bin:/sbin",
  }

  exec { "wget ovs":
    command => "wget http://10.20.0.2:8080/plugins/fuel-plugin-mark-0.0.1/repositories/ubuntu/ovs.zip && unzip ovs.zip -d $ovs_dir",
    path   => "/usr/bin:/usr/sbin:/bin:/sbin",
  }

  exec { "wget networking_ovs_dpdk":
    command => "wget http://10.20.0.2:8080/plugins/fuel-plugin-mark-0.0.1/repositories/ubuntu/networking_ovs_dpdk.zip && unzip networking_ovs_dpdk.zip -d $networking_ovs_dpdk_dir",
    path   => "/usr/bin:/usr/sbin:/bin:/sbin",
  }
}
