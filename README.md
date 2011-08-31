# Vagrant-setup

In this repo we keep our base Vagrantfile and it's respective cookboks
to setup new development environments at [Crowd Interactive](http://www.crowdint.com).

### Install

Vagrant is a nice way to setup your dev enviroments.
For further information go to [Vagrant site](http://vagrantup.com).

_Installation_

You need *VirtualBox >4.1.2* installed. Download it from
[Virtualbox site](http://www.virtualbox.org/wiki/Downloads).

    cp Vagrantfile.example Vagrantfile;
    gem install vagrant
    vagrant up

This will start a new virtual
machine from a ubuntu lucid 64bits system template. After that it will
install all the services indicated, using chef recipes (Including
postgres, mongo and redis).

*Important* if you're going to restart your computer, please stop the
vagrant execution using `vagrant suspend`.

To start a ssh session with your virtual run: `vagrant ssh`.

## Warning

*Disclaimer:* This cookbooks should never be used on production environments as
it's insecure on purpose.

## About

[CrowdInteractive](http://crowdint.com)
