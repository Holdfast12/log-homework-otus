MACHINES = {
    :ansible => {
        :box_name => "almalinux/8",
        :ip_addr => '192.168.1.2',
        :script => './ansible.sh'
    },
    :webserver => {
        :box_name => "almalinux/8",
        :ip_addr => '192.168.1.3',
        :script => './web_server.sh'
    },
    :logserver => {
        :box_name => "almalinux/8",
        :ip_addr => '192.168.1.4',
        :script => './log_server.sh'
    },
}
 

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
        config.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
        box.vm.network "private_network", ip: boxconfig[:ip_addr], netmask: "255.255.255.0", virtualbox__intnet: "otus"
        box.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "512"]
        end
        box.vm.provision "shell", inline: <<-SHELL
          sudo cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime
          echo -en "192.168.1.2 ansible\n192.168.1.3 web-server\n192.168.1.4 log-server\n\n" | sudo tee -a /etc/hosts
          cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
		      cp /vagrant/id_rsa /home/vagrant/.ssh
		      cp /vagrant/id_rsa.pub /home/vagrant/.ssh
          sudo chown 700 /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa
          sudo firewall-cmd --permanent --add-port=514/{tcp,udp}
          sudo firewall-cmd --reload
          sudo setenforce 0
          sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
          SHELL
        box.vm.provision "shell", privileged: true, path: boxconfig[:script]
    end
  end
end
