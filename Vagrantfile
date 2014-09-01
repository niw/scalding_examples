Vagrant.configure("2") do |config|
  config.vm.box = "centos-64-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  config.vm.provision :puppet, :module_path => "modules"

  [
    5005,  # for Java remove debugging

    #8020,  # Name Node
    #50010, # Data Nodes
    #50020, # Data Nodes
    50070, # Name Node Web UI
    50075, # Data Nodes Web UI
    50090, # Secondary Name Node Web UI

    #8021, # Job Tracker
    #50030, # Job Tracker Web UI
    #50060, # Task Tracker Web UI

    #8030,  # Resource Manager Scheduler
    #8031,  # Resource Manager Resource Tracker
    #8032,  # Resource Manager
    #8033,  # Resource Manager Admin
    8088,  # Resource Manager Web UI and REST APIs
    #8040,  # Node Manager Localizer
    8042,  # Node Manager Web UI and REST APIs
    #8080,  # Shuffle Handler
    #10020, # Job History
    19888  # Job History Web UI and REST APIs
  ].each do |port|
    config.vm.network :forwarded_port, :guest => port, :host  => port
  end
end
