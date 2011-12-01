# Vagrant-Setup

Vagrant is a nice way to setup your dev enviroments.
For further information go to [Vagrant site](http://vagrantup.com).

In this repo we keep our base Vagrantfile and it's respective cookboks
to setup new development environments at [Crowd Interactive](http://www.crowdint.com).

## Installation

- You need *VirtualBox >4.1.2* installed. Download it from
[Virtualbox site](http://www.virtualbox.org/wiki/Downloads).
Please include the Extension Pack as well.

### Run

Download the cookbook with the recipes for all the servers and utilities:

```bash
curl -0 https://raw.github.com/crowdint/vagrant-setup/master/downloads/cookbooks.tar.gz | tar -xz
```

Install vagrant and the virtual machine:

```bash
gem install vagrant;
vagrant up;
```

* Note that you must suspend (or halt) your vagrant before turning off your computer. Otherwise it will be aborted (like manual power off). 

Another vagrant commands:

```bash
vagrant help;     	# show commands help
vagrant status; 	# current status
vagrant suspend; 	# sleep mode
vagrant ssh;		# ssh session
```

This will start a new virtual machine from a ubuntu lucid 64bits system
template. After that it will install all the services indicated, using chef
recipes (Including postgres, mongo and redis...).

### Warning

*Disclaimer:* This cookbooks should never be used on production environments as
it's insecure on purpose.

## About

[CrowdInteractive](http://crowdint.com)
