#
# Run ansible-arch-install on test UEFI VM.
#
ansible-playbook -v -i inventory.yml --ask-pass -l testing-efi site.yml
