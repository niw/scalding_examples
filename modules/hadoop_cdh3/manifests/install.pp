class hadoop_cdh3::install {
  require jdk_6

  require cloudera_cdh3

  package {
    "hadoop-0.20":
      ensure  => installed;
  }

  package {
    "hadoop-0.20-conf-pseudo":
      ensure => installed,
      require => Package["hadoop-0.20"];
  }
}
