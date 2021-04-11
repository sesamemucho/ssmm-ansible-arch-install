#!/bin/bash
set -x
#ansible-playbook -i inventory.yml -i trenco, "$@" --skip-tags bootctl,reboot site-plain.yml
ansible-playbook -i inventory.yml -i trenco, "$@" --tags bootctl_cfg,bootctl,user_account site-plain.yml
