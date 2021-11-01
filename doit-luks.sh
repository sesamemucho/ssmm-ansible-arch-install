#!/bin/bash
set -x
#ansible-playbook -i inventory.yml --skip-tags reboot site-luks.yml
#ansible-playbook -i inventory.yml --skip-tags bootctl,reboot site-luks.yml
ansible-playbook -i inventory.yml --ask-pass "$@" --skip-tags bootctl,reboot site-luks.yml
#ansible-playbook -i inventory.yml --skip-tags sync_clock,repartition,lvm,bootctl,reboot site-luks.yml
