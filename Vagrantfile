# -*- mode: ruby -*-
# vi: set ft=ruby :

# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
required_plugins = %w( vagrant-libvirt vagrant-hostmanager )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

Vagrant.configure("2") do |config|
# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
  boxes = [
    {
      :name => "tower1.example.com",
      :box => "centos/7",
#      :version => "1705.02",
      :ram => 4096,
      :vcpu => 1,
      :ip => "192.168.29.2"
    },
    {
      :name => "tower2.example.com",
      :box => "centos/7",
#      :version => "1705.02",
      :ram => 4096,
      :vcpu => 1,
      :ip => "192.168.29.3"
    },
    {
      :name => "tower3.example.com",
      :box => "centos/7",
#      :version => "1705.02",
      :ram => 4096,
      :vcpu => 1,
      :ip => "192.168.29.4"
    },
    {
      :name => "db.example.com",
      :box => "centos/7",
#      :version => "1705.02",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.29.5"
    }
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
      config.ssh.insert_key = false
      config.vm.box = opts[:box]
      config.vm.box_version = opts[:version]
      config.vm.hostname = opts[:name]
      config.vm.provider :libvirt do |v|
        v.memory = opts[:ram]
        v.cpus = opts[:vcpu]
        v.default_prefix = "vagrant"
      end
    config.vm.network :private_network, :ip => opts[:ip]
    config.vm.provision :file do |file|
        file.source     = './keys/vagrant'
        file.destination    = '/tmp/vagrant'
       end
    config.vm.provision :file do |file|
        file.source     = './inventory'
        file.destination    = '/home/vagrant/inventory'
       end
    config.vm.provision :file do |file|
        file.source     = './ansible-tower-install.sh'
        file.destination    = '/home/vagrant/ansible-tower-install.sh'
       end
   config.vm.provision :shell, path: "bootstrap-node.sh"
   config.vm.provision :shell, path: "ansible-installer.sh"
   end
  end
end
