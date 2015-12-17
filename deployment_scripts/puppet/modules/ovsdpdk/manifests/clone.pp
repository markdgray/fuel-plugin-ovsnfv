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

  package { 'git':
    ensure   => installed,
  }

  package { 'unzip':
    ensure   => installed,
  }

  package { 'python-pip':
    ensure   => installed,
  }

  package { 'python-iniparse':
    ensure   => installed,
  }

  package { 'crudini':
    ensure   => installed,
  }

  exec { "wget dpdk":
    command => "rm -rf dpdk.zip $ovs_dpdk_dir && wget http://10.20.0.2:8080/plugins/fuel-plugin-ovsnfv-0.0/repositories/ubuntu/dpdk.zip && unzip dpdk.zip && mv dpdk-2.1.0 $ovs_dpdk_dir",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    require => Package['unzip'],
  }

  exec { "wget ovs":
    command => "rm -rf ovs.zip $ovs_dir && wget http://10.20.0.2:8080/plugins/fuel-plugin-ovsnfv-0.0/repositories/ubuntu/ovs.zip && unzip ovs.zip && mv ovs-master $ovs_dir",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    require => Package['unzip'],
  }

  exec { "wget networking_ovs_dpdk":
    command => "rm -rf networking-ovs-dpdk.zip $networking_ovs_dpdk_dir && wget http://10.20.0.2:8080/plugins/fuel-plugin-ovsnfv-0.0/repositories/ubuntu/networking-ovs-dpdk.zip && unzip networking-ovs-dpdk.zip && mv networking-ovs-dpdk $networking_ovs_dpdk_dir",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    require => Package['unzip'],
  }

  exec { "install pbr":
    command => "wget http://10.20.0.2:8080/plugins/fuel-plugin-ovsnfv-0.0/repositories/ubuntu/pbr-1.8.1-py2.py3-none-any.whl && pip install pbr-1.8.1-py2.py3-none-any.whl",
    path    => "/usr/bin:/usr/sbin:/bin:/sbin",
    require => Package['python-pip'],
  }
}
