
# Development / Test environment

Tools to set up a development / test environment
with two VMs each a host of VMs with libvirt installed.

The intended use of this setup is to test VM migration.

*Note*: this setup only works when nested virtualization is enabled

## Commands

`build-environment`
: script to generate a common backing image `appliance.qcow2` and
  two host images `vmhost1.qcow2` and `vmhost2.qcow2` with associated
  xml files to create/start VMs

`start-environment`
: script to start `vmhost1` and `vmhost2` virtual machines

`destroy-environment`
: script to destroy `vmhost1` and `vmhost2` (without shutdown)

`clean-environment`
: script to remove intermediate files and VM artifacts

