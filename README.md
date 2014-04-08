# Vagrant box for CKAN (2.0)

[CKAN](http://ckan.org) (the apt-get for opendata) is an open-source portal application developed by the [OKFN](http://okfn.org).

In order to make the getting started part easier I created this shell script to create a CKAN instance with the help of vagrant, a nice wrapper around virtualbox that creates and manages virtual machines.


## Setup

1. Install [Virtualbox](https://www.virtualbox.org)
2. Install [vagrant](http://www.vagrantup.com)
3. Clone this repository `git clone git://github.com/philippkueng/ckan-vagrant.git`
4. Move to the directory with your terminal application `cd ckan-vagrant/`
5. Create the instance `vagrant up`
6. Go get some coffee (it takes up to 15 minutes)
7. Add to following line to `/etc/hosts`:  `192.168.19.97 ckan.lo`
8. Open [http://ckan.lo](http://ckan.lo) in your browser.
	

## License

		               DO WHAT YOU WANT TO PUBLIC LICENSE
		                    Version 3, January 2012

		 Copyright (C) 2012 Ryan Thompson

		 Everyone is permitted to copy and distribute verbatim or modified
		 copies of this license document, and changing it is allowed as long
		 as the name is changed.

		                DO WHAT YOU WANT TO PUBLIC LICENSE
		   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

		  0. You just DO WHAT YOU WANT TO.
