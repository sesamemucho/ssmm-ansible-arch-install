#!/bin/bash
set -x
ansible-playbook -i inventory.yml -i michiba, "$@" --skip-tags bootctl,reboot site-luks.yml
