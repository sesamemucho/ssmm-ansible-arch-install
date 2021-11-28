#!/bin/bash
ansible-playbook -i inventory.yml -i kaga, --ask-pass "$@" site.yml
