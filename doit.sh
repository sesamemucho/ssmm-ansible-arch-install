#!/bin/bash
ansible-playbook -i inventory.yml --ask-pass "$@" site.yml
