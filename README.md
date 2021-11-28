# ansible-arch-install #

An Ansible playbook to help install Arch Linux. Forked from
[jsf9k/ansible-arch-install](https://github.com/jsf9k/ansible-arch-install)

Through variable settings, this can install to UEFI or BIOS systems.
By default, the root filesystem is btrfs, but this can be changed.
Also by default, it uses LUKS disk encryption. You should be able to
disable this, but the non-LUKS setup isn't currently working.

For testing and development, there are scripts to start KVM virtual
machines for BIOS and UEFI work.

## Example Runthrough with EFI VM ##

I think it would be easiest to start with a quick run-through.

0. Prerequisites.
   You should be able to run KVM virtual machines with libvirt.
   Packages/programs:
       virsh
       virt-manager
   You will need to be able to use the qemu:///system connection. What
   this means is that your user needs to be in the 'libvirt' group. To
   do this, if you're not already there, run
   `sudo usermod -a -G libvirt your-user-name`, then logout and log
   back in.
   
   You will need an internet connection for installing Arch Linux
   packages on the VM.
   
   You will need a recent Archlinux ISO. As of this writing, the name
   is archlinux-2021.11.01-x86_64.iso
   
1. Go to the right place.
   Checkout this repository.
   `cd /path/to/ssmm-ansible-arch-install`

2. Set up the configuration.
   In the repository, the file 'group_vars/home.yml' is encrypted with
   ansible-vault. You can make another encrypted home.yml, or you can
   leave it unencrypted. In any case, it should look something like
   the following:
   
   ---
   ansible_user: root
   ansible_ssh_common_args: -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"
   user_name: dogtoy
   
   By default, the luks keyfile is named './home_keyfile'. Make this
   file with your favorite passphrase inside:
   `echo 'my passphrase' > ./home_keyfile`

3. Start the VM.
   In one console/widow,
   `testing/scripts/start-efi-vm.sh /path/to/arch/iso`
   
4. Set up the VM
   The start-efi-vm.sh will open a console to the VM. Login as
   'root'. Run `passwd` to set the root password to (say) 'rootpass'.

5. Start the ansible process.
   In another console/window,
   `./do-test-efi.sh`
   It will ask for an SSH password. Give it the same password you set
   in step 4.

   This should finish without errors in several minutes.
   
6. Shut down VM.
   Type `poweroff` in the vm console from step 4. This will shut down
   the VM and cause the 'testing/scripts/start-efi-vm.sh' script to
   exit.
   
7. Restart VM.
   In `virt-manager`, start the 'testing-efi' VM and open a console.
   Give it the LUKS passphrase from step 3, and then login as the user
   (step 3) with the password 'password'. You will be required to
   immediately change this to something else.
   
8. Yay!
   If you've reached this step, you have succeeded! You now have a
   bare-bones Arch Linux install which you can customize (say, with
   [ssmm-ansible-home](https://github.com/sesamemucho/ssmm-ansible-home)).
   Well, not the VM (it's very small), but you can do the same for a
   laptop or other machine, or a larger VM.
   
9. The example was for an EFI VM. You can do the same for BIOS; just
   substitute 'bios' for 'efi' above.

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

## Notes ##

Useful links:

[Linux: Full Disk Encryption with BIOS, UEFI using MBR, GPT, LUKS, LVM and GRUB](https://www.rohlix.eu/post/linux-disk-encryption-with-bios-uefi-using-mbr-gpt-luks-lvm-and-grub/)

