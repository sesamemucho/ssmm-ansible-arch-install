#!/bin/bash
set -x
ansible-playbook -i inventory.yml --ask-pass "$@" site-luks-bios.yml
