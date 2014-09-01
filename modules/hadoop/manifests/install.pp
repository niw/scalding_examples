class hadoop::install {
  require jdk_7

  package {
    "hadoop-conf-pseudo":
      require => Yumrepo["cloudera"],
      ensure => installed;
  }
}
