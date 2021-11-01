#!/bin/bash
set -x
ansible-playbook -i inventory.yml -i kaga, --ask-pass "$@" --skip-tags bootctl,reboot site-luks.yml
