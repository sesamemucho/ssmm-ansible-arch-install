#
# Run ansible-arch-install on test BIOS VM.
#
ansible-playbook "$@" -i inventory.yml --ask-pass -l testing-bios site.yml
