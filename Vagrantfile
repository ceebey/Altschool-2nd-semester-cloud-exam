Vagrant.configure("2") do |config|
  
  # Define the 'Slave' Node
config.vm.define "slave" do |slave|
    slave.vm.box = "ubuntu/jammy64"
    slave.vm.hostname = "Slave"
    slave.vm.network "private_network", ip: "192.168.56.5"
    slave.vm.boot_timeout = 1800
    # Provision the 'Slave' VM with a LAMP stack using a shell script
    slave.vm.provision "shell", path: ""
   
  end

 


  # Define the 'Master' Node
 config.vm.define "master02" do |master02|
  master02.vm.box = "ubuntu/jammy64"
  master02.vm.hostname = "Master"
  master02.vm.network "private_network", ip: "192.168.56.7"
  master02.vm.boot_timeout = 2400
  # Provision the 'Master' VM with a LAMP stack using a shell script
  master02.vm.provision "shell", path: "deploy.sh"

 end
end