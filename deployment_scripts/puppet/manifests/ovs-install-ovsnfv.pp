$fuel_settings = parseyaml(file('/etc/compute.yaml'))
if $operatingsystem == 'Ubuntu' {
  class { '::ovsdpdk':
    ovs_bridge_mappings => '',
    ovs_socket_mem      => '512',
    ovs_num_hugepages   => '300',
  }
} elsif $operatingsystem == 'CentOS' {
}
