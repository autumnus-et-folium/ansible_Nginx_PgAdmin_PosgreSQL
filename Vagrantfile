Vagrant.configure("2") do |config|
  # Общие настройки для всех машин
  config.vm.box = "generic/ubuntu2204" #"generic-rocky9"
  config.vm.synced_folder ".", "/vagrant", SharedFoldersEnableSymlinksCreate: false
  config.ssh.insert_key = false
  #config.vm.box_url = "./generic-rocky9" # локальный image
  #config.vm.box_url = "http://example.com/path/to/box" # свой сервер

  config.vm.define "dockerNginx" do |vm|
    #vm.vm.box = "eurolinux-vagrant/rocky-9" # вдруг захочу задействовать rockylinux (потестить ансибл факты и установку ПО через условия) - локальное переопределение
    vm.vm.hostname = "dockerNginx"

    vm.vm.network "private_network",
      ip: "192.168.110.12",
      libvirt__network_name: "custom_net"

    vm.vm.provider :libvirt do |libvirt|
      libvirt.cpus = 2
      libvirt.memory = 3072
      #libvirt.machine_virtual_size = 10 # в generic/ubuntu2204 скорей всего встроенные метаданные размера диска - мои настройки игнорируются
    end
  end

  config.vm.define "dockerPgadminPostgres" do |vm|
    #vm.vm.box = "eurolinux-vagrant/rocky-9" # вдруг захочу задействовать rockylinux (потестить ансибл факты и установку ПО через условия) - локальное переопределение
    vm.vm.hostname = "dockerPgadminPostgres"

    vm.vm.network "private_network",
      ip: "192.168.110.13",
      libvirt__network_name: "custom_net"

    vm.vm.provider :libvirt do |libvirt|
      libvirt.cpus = 4
      libvirt.memory = 4096
      #libvirt.machine_virtual_size = 15 
    end
  end
end
