#
# Run ansible-arch-install on test BIOS VM.
#
set -x
ansible-playbook -vv -i inventory.yml --ask-pass -l testing-bios site-luks-bios.yml
