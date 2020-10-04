Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.define "pam" do |pam|
    pam.vm.network "private_network", ip: "192.168.50.10", virtualbox__intnet: "net1"
    pam.vm.hostname = "pam"
    pam.vm.provision "shell", path: "scripts/pam.sh"
  end
end