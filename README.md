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

## What You Will See

On Mac you will be prompted for your password by vagrant to grant permission for the nfs network share. Give your account password for your Mac.

```shell
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
[default] Importing base box 'precise64'...
[default] Matching MAC address for NAT networking...
[default] Setting the name of the VM...
[default] Clearing any previously set forwarded ports...
Pruning invalid NFS exports. Administrator privileges will be required...
Password:
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Preparing network interfaces based on configuration...
[default] Forwarding ports...
[default] -- 22 => 2222 (adapter 1)
[default] Running 'pre-boot' VM customizations...
[default] Booting VM...
[default] Waiting for machine to boot. This may take a few minutes...
[default] Machine booted and ready!
[default] Configuring and enabling network interfaces...
[default] Mounting shared folders...
[default] Exporting NFS shared folders...
Preparing to edit /etc/exports. Administrator privileges will be required...
[default] Mounting NFS shared folders...
[default] Running provisioner: shell...
[default] Running: /var/folders/t_/362369v15vzdns6pjxs0s1qh0000gn/T/vagrant-shell20131101-54442-qsp9da
stdin: is not a tty
this shell script is going to setup a running ckan instance based on the CKAN 2.0 packages
switching the OS language
Generating locales...
  en_AG.UTF-8... done
  en_AU.UTF-8... done
  en_BW.UTF-8... done
  en_CA.UTF-8... done
  en_DK.UTF-8... done
  en_GB.UTF-8... done
  en_HK.UTF-8... done
  en_IE.UTF-8... done
  en_IN.UTF-8... done
  en_NG.UTF-8... done
  en_NZ.UTF-8... done
  en_PH.UTF-8... done
  en_SG.UTF-8... done
  en_US.ISO-8859-1... up-to-date
  en_US.UTF-8... up-to-date
  en_ZA.UTF-8... done
  en_ZM.UTF-8... done
  en_ZW.UTF-8... done
Generation complete.
Generating locales...
  en_US.UTF-8... up-to-date
Generation complete.
updating the package manager
Ign http://us.archive.ubuntu.com precise InRelease
Ign http://us.archive.ubuntu.com precise-updates InRelease
Ign http://us.archive.ubuntu.com precise-backports InRelease
Get:1 http://us.archive.ubuntu.com precise Release.gpg [198 B]
Ign http://security.ubuntu.com precise-security InRelease

...etc...

Initialising DB: SUCCESS
enabling filestore with local storage
 * Restarting web server apache2
apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName
 ... waiting apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName
   ...done.
creating an admin user
2013-11-01 18:56:17,687 CRITI [ckan.logic] activity_create was pass extra keywords {'ignore_auth': True}
Creating user: 'admin'
{'about': None,
 'activity_streams_email_notifications': False,
 'apikey': u'09fcee4f-5166-451f-bed6-3be4dcd65be9',
 'created': '2013-11-01T18:56:17.687049',
 'display_name': u'admin',
 'email': u'admin@email.org',
 'email_hash': 'ef7ba7dba0b6de1cb0ee35c02d1757fc',
 'fullname': None,
 'id': u'8c009b23-ef27-489d-b562-60ec6541723a',
 'name': u'admin',
 'number_administered_packages': 0L,
 'number_of_edits': 1L,
 'openid': None,
 'reset_key': None,
 'sysadmin': False}
Added admin as sysadmin
loading some multilingual test data
2013-11-01 18:56:19,257 INFO  [ckan.model] Database tables created
2013-11-01 18:56:19,257 INFO  [ckan.websetup] Creating tables: SUCCESS
Running setup_app() from ckan.websetup
Creating translations test data
Creating translations test data: Complete!
you should now have a running instance on http://ckan.lo
```
	

## License

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
