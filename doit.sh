#!/bin/bash
set -x
ansible-playbook -i inventory.yml --skip-tags bootctl,reboot site-luks.yml
