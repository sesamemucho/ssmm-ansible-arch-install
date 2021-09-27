#!/bin/bash
set -x
ansible-playbook -i inventory.yml -i sakai, --ask-pass "$@" site-luks-bios.yml
