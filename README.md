# Alternate Tectonic Deployment

This repo is meant to provide alternative means of deploying Tectonic with platforms that do not support PXE.

## Introduction

Tectonic Baremetal deployment relies on infrastructure services such as PXE/DHCP/DNS. These services may not always be in control of users who would like to test Tectonic. This repo provides documentation and scripting as an alternative workflow to deploy Tectonic utilizing Ignition [0].

Alternative workflow to deploy Tectonic at a high level consists of following steps:

1. Deploy CoreOS Matchbox
2. Generate Ignition Assets
3. Feed Ignition Assets to CoreOS Instances
4. Upload Tectonic cluster assets bundle
5. Verify deployment

This repo provides scripts and manifests to ease the process, however some knowledge of CoreOS Container Linux and Kubernetes may be required.

## Deploy CoreOS Matchbox 

### Using Vagrant

See official Vagrant website getting started with Vagrant (https://www.vagrantup.com/). Once vagrant is deployed on your machine, use git to clone the repository.

`git clone https://github.com/alekssaul/tectonic-vagrant.git ; cd tectonic-vagrant; vagrant up`

### Without Vagrant

Repository provides a cloud-config manifest inside the user-data text file. Use the cloud-config to deploy a CoreOS instance in a supported platform. 

You can follow the documentation in; "https://coreos.com/tectonic/docs/latest/install/bare-metal/index.html#\32 -provisioning-infrastructure" . Once completed, continue to "https://coreos.com/tectonic/docs/latest/install/bare-metal/index.html#\34 -tectonic-installer" section, but execute the installer with `-address 0.0.0.0:80 -open-browser=false` flags ex: `./installer -address 0.0.0.0:80 -open-browser=false`

## Generate Ignition Assets

You edit the file use the variables.tmpl.sh and use create-assets.sh script to generate ignition assets.

Alternatively, you can run thru the Tectonic baremetal install process. Once the installation proceeds, download the assets.zip file. You can generate ignition files via

`curl "http://${MATCHBOX_IP}:8080/ignition?uuid=19974d56-4178-078f-6ab8-a7a52d6d6204&mac=00-00-00-00-00-00&os=installed" -o controller_ignition.json`

Where `MAC=00-00-00-00-00-00` is the MAC address of the controller node entered during the installation.

`curl "http://${MATCHBOX_IP}:8080/ignition?uuid=8a0dee8e-fd62-4148-828b-024e8cb3033b&mac=00-00-00-00-00-10&os=installed" -o worker_ignition.json`

Where `MAC=00-00-00-00-00-10` is the MAC address of the worker node entered during the installation.

## Feed Ignition Assets to CoreOS Instances

Follow the Ignition documenation available in; https://coreos.com/ignition/docs/latest/supported-platforms.html

## Upload Tectonic cluster assets bundle

Once the machines are provisioned with Ignition confirm that name resolution works between the nodes and the values entered for cluster and tectonic during the installer resolves as expected.

SSH the assets.zip to the controller server and execute following lines

```
$ unzip /home/core/assets.zip
$ sudo mv /home/core/assets /opt/bootkube/
$ sudo chmod a+x /opt/bootkube/assets/bootkube-start
$ sudo systemctl start bootkube
```

## Verify deployment

Execute `journalctl -u bootkube -f` to confirm bootkube started as expected. You can use the kubectl binary with the kubeconfig file located in auth folder of assets bundle to connect to the cluster. Tectonic console should be available on https://tectonic-url entered during the install

[0] https://coreos.com/ignition/docs/latest/