Vagrant.configure("2") do |config|

  # Define the 'Slave' Node
 config.vm.define "slave" do |slave|
  slave.vm.box = "ubuntu/jammy64"
  slave.vm.hostname = "Slave"
  slave.vm.network "private_network", ip: "192.168.56.5"
  slave.vm.boot_timeout = 2000
  
 
 end

  # Define the 'Master' Node
 config.vm.define "master02" do |master02|
  master02.vm.box = "ubuntu/jammy64"
  master02.vm.hostname = "Master"
  master02.vm.network "private_network", ip: "192.168.56.7"
  master02.vm.boot_timeout = 2400

 # Install Ansible on the master
  master02.vm.provision "shell", inline: "sudo apt update"
  master02.vm.provision "shell", inline: "sudo apt install software-properties-common"
  master02.vm.provision "shell", inline: "sudo add-apt-repository --yes --update ppa:ansible/ansible"
  master02.vm.provision "shell", inline: "sudo apt install ansible"

  # Provision the 'Master' VM with a LAMP stack using a shell script
  master02.vm.provision "shell", path: "LAMP.sh"
  master02.vm.provision "shell", path: "deploy.sh"

  #provison the master VM to copy files from host computer to varant master02 vm
  master02.vm.provision "file", source: "LAMP.sh", destination: "/home/vagrant/LAMP.sh"
  master02.vm.provision "file", source: "deploy.sh", destination: "/home/vagrant/deploy.sh"
  master02.vm.provision "file", source: "playbook.yaml", destination: "/home/vagrant/playbook.yaml"
end


end 
  