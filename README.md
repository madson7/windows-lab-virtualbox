
# Windows lab virtualbox Openstack

## About

windows-lab-virtualbox provides an automated way to deploy OpenStack, closely
following the
OpenStack Install Guide https://docs.openstack.org/install-guide

windows-lab-virtualbox offers an easy way to set up an OpenStack cluster which is a good
starting point for beginners to learn OpenStack, and for advanced users to test
out new features, and check out different capabilities of OpenStack.

On top of that windows-lab-virtualbox is also a good way to test the installation
instructions on a regular basis.

windows-lab-virtualbox is a project under OpenStack Documentation. For more information
see the
OpenStack wiki https://wiki.openstack.org/wiki/Documentation/training-labs

* Free software: Apache license
* Documentation: openstack-windows-lab-virtualbox https://docs.openstack.org/training_labs/
* Source: openstack/windows-lab-virtualbox https://github.com/madson7/windows-lab-virtualbox.git

## Pre-requisite

* Download and install VirtualBox https://www.virtualbox.org/wiki/Downloads

VirtualBox is the default hypervisor used by windows-lab-virtualbox. Alternatively, you can use KVM (just set PROVIDER=kvm in labs/config/localrc).


## Getting the Code for an OpenStack Release

The current release is master which usually deploys the current stable
OpenStack release. Unless you have a reason to go with an older release,
we recommend using master.

## Run the scripts for Windows

The easiest and recommended way to get everything you need besides VirtualBox is to clone the Windows Lab virtualbox repository https://github.com/madson7/windows-lab-virtualbox.git

Include pre-generated Windows batch files.

Creates the host-only networks used by the node VMs to communicate:

    > create_hostnet.bat

Creates the base disk:

    > create_base.bat

Creates the node VMs based on the base disk:

    > create_ubuntu_cluster_node.bat

## What the script installs

Running this will automatically spin up 2 virtual machines in VirtualBox/KVM:

* Controller node
* Compute node

Now you have a multi-node deployment of OpenStack running with the following services installed.

* Keystone
* Nova
* Neutron
* Glance
* Cinder
* Horizon

## How to access the services

There are two ways to access the services:

* OpenStack Dashboard (horizon)

You can access the dashboard at: http://127.0.0.1:8888/horizon/auth/login/?next=/horizon/

Admin Login:

* Domain: ``Default``
* Username: ``admin``
* Password: ``admin_user_secret``

Demo User Login:

* Domain: ``Default``
* Username: ``myuser``
* Password: ``myuser_user_pass``

You can ssh to each of the nodes by:

    # Controller node
    > ssh osbash@localhost -p 2230

    # Compute node
    > ssh osbash@localhost -p 2232

Credentials for all nodes:

* Username: ``osbash``
* Password: ``osbash``

After you have ssh access, you need to source the OpenStack credentials in order to access the services.

Two credential files are present on each of the nodes:

* ``admin-openrc.sh``
* ``source demo-openrc.sh``

Source the following credential files

For Admin user privileges:

    $ source admin-openrc.sh

For Demo user privileges:

    $ source source demo-openrc.sh

Note: Instead 'source' you can use '.', or you define an alias.
Now you can access the OpenStack services via CLI.

## Specs

To review specifications, see Training-labs
https://specs.openstack.org/openstack/docs-specs/specs/liberty/training-labs.html

## Wiki

Siga vários links em laboratórios de treinamento aqui: https://wiki.openstack.org/wiki/Documentation/training-labs