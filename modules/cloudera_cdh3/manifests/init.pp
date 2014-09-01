class cloudera_cdh3 {
  yumrepo {
    "cloudera":
      descr => "Cloudera's Distribution for Hadoop, Version 3",
      mirrorlist => "http://archive.cloudera.com/redhat/cdh/3/mirrors",
      enabled => 1,
      gpgcheck => 1,
      gpgkey => "http://archive.cloudera.com/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera";
  }
}
