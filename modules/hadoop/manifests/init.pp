class hadoop {
  include install
  include service

  Class["install"]
  ~> Class["service"]

  service {
    "iptables":
      enable => false,
      ensure => stopped;
  }
}
