Vagrant.configure("2") do |config|

  config.vm.box = "gusztavvargadr/windows-10"

  config.vm.communicator = "winrm"
  config.winrm.port = "5986"

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 9990, host: 9990

  # Config SSH port to acces VM
  config.vm.network "forwarded_port", guest: 22, host: 2242, host_ip: "0.0.0.0", id: "ssh", auto_correct: true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessable to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |v|
    v.name = "windows_deployment"
    v.memory = 2048
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.

  # Adding .pub key
  config.vm.provision "file" do |f|
    f.source = "configuration/ssh/windows-deployment-key.pub"
    f.destination = "C:/Users/vagrant/Documents"
  end

  config.vm.provision "shell" do |s|
    s.path = "configuration/scripts/setup.ps1"
    s.name = "Setup machine dependencies"
  end

end
