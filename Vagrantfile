# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
    :webmachine => {
        :box_name => "almalinux/8",
        :ip_addr => '192.168.1.3',
        :guest_port1 => '80',
        :host_port1 => '8080'
    },
    :logmachine => {
        :box_name => "almalinux/8",
        :ip_addr => '192.168.1.4',
        :guest_port1 => '5601',
        :host_port1 => '5601'
    },
}
 

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.ssh.forward_agent = true
  config.ssh.private_key_path = ['id_rsa', '~/.vagrant.d/insecure_private_key']
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
        config.vm.box_check_update = false
        config.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
        box.vm.network "forwarded_port", guest: boxconfig[:guest_port1], host: boxconfig[:host_port1]
        box.vm.network "private_network", ip: boxconfig[:ip_addr], netmask: "255.255.255.0", virtualbox__intnet: "otus"
        box.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "512"]
        end
        box.vm.provision "shell", inline: <<-SHELL
          echo -en "192.168.1.3 webmachine\n192.168.1.4 logmachine\n\n" | sudo tee -a /etc/hosts
          cat /vagrant/ssh_config > /home/vagrant/.ssh/config
          sudo chown vagrant:vagrant /home/vagrant/.ssh/config
          sudo chmod 700 /home/vagrant/.ssh/config
          sudo setenforce 0
          sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
          SHELL
        box.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/playbook.yml"
        end
    end
  end
end
