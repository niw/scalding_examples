class jdk_6 {
  $dist_file = "jdk-6u45-linux-x64-rpm.bin"
  $dist_dir = "/tmp"

  $package_name = "jdk-1.6.0_45-fcs"
  $package_file = "jdk-6u45-linux-amd64.rpm"

  $dist_path = "${dist_dir}/${dist_file}"
  $package_path = "${dist_dir}/${package_file}"

  file {
    $dist_path:
      ensure => present,
      owner => "root",
      group => "root",
      mode => 0755,
      source => "puppet:///modules/jdk_6/${dist_file}";
  }

  exec {
    $package_path:
      command => "/bin/sh -c 'cd ${dist_dir} && exec ./${dist_file}'",
      creates => $package_path,
      require => File[$dist_path];
  }

  ->

  package {
    $package_name:
      ensure => $ensure,
      source => $package_path,
      provider => rpm,
      require => Exec[$package_path];
  }
}
