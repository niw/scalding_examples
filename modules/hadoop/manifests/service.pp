class hadoop::service {
  exec {
    "/usr/bin/hdfs namenode -format":
      user => "hdfs",
      creates => "/var/lib/hadoop-hdfs/cache/hdfs/dfs/name",
      refreshonly => true;
  }

  ->

  service {
    "hadoop-hdfs-namenode":
      enable => true,
      ensure => running,
      hasrestart => true;

    "hadoop-hdfs-secondarynamenode":
      enable => true,
      ensure => running,
      hasrestart => true;

    "hadoop-hdfs-datanode":
      enable => true,
      ensure => running,
      hasrestart => true;
  }

  ~>

  exec {
    "/bin/sh -c '/usr/bin/hadoop fs -rm -r /tmp;
                 /usr/bin/hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate &&
                 /usr/bin/hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging &&
                 /usr/bin/hadoop fs -chmod -R 1777 /tmp'":
      user => "hdfs",
      unless => "/usr/bin/hadoop fs -ls /tmp/hadoop-yarn/staging";

    "/bin/sh -c '/usr/bin/hadoop fs -mkdir -p /var/log/hadoop-yarn &&
                 /usr/bin/hadoop fs -chown yarn:mapred /var/log/hadoop-yarn'":
      user => "hdfs",
      unless => "/usr/bin/hadoop fs -ls /var/log/hadoop-yarn";

    "/bin/sh -c '/usr/bin/hadoop fs -mkdir -p /user/vagrant &&
                 /usr/bin/hadoop fs -chown -R vagrant /user/vagrant'":
      user => "hdfs",
      unless => "/usr/bin/hadoop fs -ls /user/vagrant";
  }

  ->

  service {
    "hadoop-yarn-resourcemanager":
      enable => true,
      ensure => running,
      hasrestart => true;

    "hadoop-yarn-nodemanager":
      enable => true,
      ensure => running,
      hasrestart => true;

    "hadoop-mapreduce-historyserver":
      enable => true,
      ensure => running,
      hasrestart => true;
   }
}
