# ansible-arch-install #

An Ansible playbook to help install Arch Linux.

## Usage ##

After booting from the Arch installation media, you will need to:
0. Set up a network connection with something like
   iwctl -P passphrase station wlan0 connect "SSID".
1. Set the root password using the `passwd` command.
2. Create a keyfile on your local host containing the password for
   your LUKS root volume via `echo -n "your_password" > keyfile`.
3. The user password will be 'password', and will have to be changed
   on your first login.

At this point we are able to login remotely as root, so we can
populate `inventory.yml` and run `site.yml`:

```console
ansible-playbook -i inventory.yml site.yml
```

Note that you may have to fiddle with the UEFI settings in the BIOS in
order to get the new installation to boot.

At this point your new Arch Linux system is ready to be configured.
The project
[jsf9k/ansible-home](https://github.com/jsf9k/ansible-home) can be
used for this purpose.

site-luks.yml builds an EFI system with LUKS, but no LVM.
site-luks-bios.yml builds an BIOS system with LUKS, but no LVM.

mkinitcpio:
https://wiki.archlinux.org/title/Dm-crypt/System_configuration#mkinitcpio

