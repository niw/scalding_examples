class jdk_7 {
  $package_name = "jdk-1.7.0_67-fcs.x86_64"
  $package_file = "jdk-7u67-linux-x64.rpm"
  $package_path = "/tmp/${package_file}"

  file {
    $package_path:
      ensure => present,
      owner => "root",
      group => "root",
      mode => 0644,
      source => "puppet:///modules/jdk_7/${package_file}";
  }

  package {
    $package_name:
      ensure => $ensure,
      source => $package_path,
      provider => rpm,
      require => File[$package_path];
  }
}
