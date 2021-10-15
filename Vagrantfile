IMAGE_NAME = "dummy.box"
MASTERS_NUM = 1
NODES_NUM = 1

IP_BASE = "192.168.0."

VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

Vagrant.configure("2") do |config|
    config.ssh.insert_key = true
    config.ssh.username = 'devops'
    config.ssh.forward_agent = true
    config.ssh.private_key_path = "~/.ssh/id_rsa"
    config.vm.synced_folder ".", "/vagrant", disabled: true
  
    (1..NODES_NUM).each do |j|
        config.vm.define "k8s-node-#{j}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "#{IP_BASE}#{j + 61 + MASTERS_NUM}"
            node.vm.hostname = "k8s-node-#{j}"
            config.vm.provider :vsphere do |vsphere|
                vsphere.host = 'vcsa'
                vsphere.compute_resource_name = 'AlexCluster'
                vsphere.resource_pool_name = ''
                vsphere.vm_base_path = 'k8s'
                vsphere.customization_spec_name = 'centos7'
                vsphere.template_name = 'c7-empty'
                vsphere.user = 'Administrator@alex.local'
                vsphere.password = 'P@sw0rd1'
                vsphere.insecure = true
            end          
        end
    end
end
