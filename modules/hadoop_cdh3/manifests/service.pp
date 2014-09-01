class hadoop_cdh3::service {
  service {
    "hadoop-0.20-namenode":
      enable => true,
      ensure => running,
      hasrestart => true;

    "hadoop-0.20-tasktracker":
      enable => true,
      ensure => running,
      hasrestart => true,
      require => Service["hadoop-0.20-namenode"];

    "hadoop-0.20-datanode":
      enable => true,
      ensure => running,
      hasrestart => true,
      require => Service["hadoop-0.20-namenode"];

    "hadoop-0.20-jobtracker":
      enable => true,
      ensure => running,
      hasrestart => true,
      require => Service["hadoop-0.20-namenode", "hadoop-0.20-tasktracker"];
  }

  ~>

  exec {
    "/bin/sh -c '/usr/bin/hadoop fs -mkdir -p /user/vagrant &&
                 /usr/bin/hadoop fs -chown -R vagrant /user/vagrant'":
      user => "hdfs",
      unless => "/usr/bin/hadoop fs -ls /user/vagrant";
  }
}
