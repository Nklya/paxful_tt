Vagrant.configure("2") do |config|

  # Use one key
  config.ssh.insert_key = false
  config.ssh.private_key_path = '~/.vagrant.d/insecure_private_key'

  # Set memory
  config.vm.provider :virtualbox do |v|
    v.memory = 512
  end

  # Define app server
  config.vm.define "appserver" do |app|
    app.vm.box = "debian/stretch64"
    app.vm.hostname = "appserver"
    app.vm.network :private_network, ip: "10.10.10.10"

    # app.vm.provision "ansible" do |ansible|
    #   ansible.playbook = "app.yml"
    # end
  end

  # Define dbmaster server
  config.vm.define "dbmaster" do |db|
    db.vm.box = "debian/stretch64"
    db.vm.hostname = "dbmaster"
    db.vm.network :private_network, ip: "10.10.10.21"

    # db.vm.provision "ansible" do |ansible|
    #   ansible.playbook = "db.yml"
    # end
  end

  # Define dbslave server
  config.vm.define "dbslave" do |db|
    db.vm.box = "debian/stretch64"
    db.vm.hostname = "dbslave"
    db.vm.network :private_network, ip: "10.10.10.22"

    # db.vm.provision "ansible" do |ansible|
    #   ansible.playbook = "db.yml"
    # end
  end
end
