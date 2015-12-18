if $operatingsystem == 'Ubuntu' {
  class { '::ovsdpdk':
    ovs_bridge_mappings => '',
    ovs_socket_mem      => '512',
    ovs_num_hugepages   => '256',
  }
} elsif $operatingsystem == 'CentOS' {
}
