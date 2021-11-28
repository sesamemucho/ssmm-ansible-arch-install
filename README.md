# ansible-arch-install #

An Ansible playbook to help install Arch Linux. Forked from
[jsf9k/ansible-arch-install](https://github.com/jsf9k/ansible-arch-install)

Through variable settings, this can install to UEFI or BIOS systems.
By default, the root filesystem is btrfs, but this can be changed.
Also by default, it uses LUKS disk encryption. You should be able to
disable this, but the non-LUKS setup isn't currently working.

For testing and development, there are scripts to start KVM virtual
machines for BIOS and UEFI work.

## Usage ##

For details on configuration, see the [Configuration](#configuration) section below.

After booting from the Arch installation media, you will need to:
0. Set up a network connection with something like
   iwctl -P passphrase station wlan0 connect "SSID". If you have a
   wired connection, set the "wired_interface" variable to the device
   name of the wired interface and no further action is needed
   (assuming the network has DHCP available).
1. Set the root password using the `passwd` command. The installation
   script will request this password when it starts on the host.
2. Create a keyfile on your local host containing the password for
   your LUKS root volume via `echo -n "your_password" > keyfile`. The
   default name of the keyfile is "home_keyfile" and is set with the
   'luks_keyfile' variable.
3. The user password will be 'password', and will have to be changed
   on your first login.

At this point we are able to login remotely as root, so we can
populate `inventory.yml` and run `site.yml`:

```console
ansible-playbook -i inventory.yml -l hostname site.yml
```

Note that you may have to fiddle with the UEFI settings in the BIOS in
order to get the new installation to boot.

At this point your new Arch Linux system is ready to be configured.
The project
[jsf9k/ansible-home](https://github.com/jsf9k/ansible-home) can be
used for this purpose.

## Configuration ##

Basically, set up a `host_vars/hostname.yml` file with the IP address
and any other needed customizations; make sure the hostname is in the
inventory.yml file and set up the 'home_keyfile'.

mkinitcpio:
https://wiki.archlinux.org/title/Dm-crypt/System_configuration#mkinitcpio

