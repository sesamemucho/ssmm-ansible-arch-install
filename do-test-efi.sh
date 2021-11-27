#
# Run ansible-arch-install on test UEFI VM.
#
set -x
ansible-playbook -v -i inventory.yml --ask-pass -l testing-efi site-luks-bios.yml
