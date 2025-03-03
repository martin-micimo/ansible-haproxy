#!/bin/bash

# Create a Copy of this Role
WORKDIR=$(mktemp -d)
cp -r ../. $WORKDIR

# Execute Playbook in Copied Directory
time ansible-playbook --vault-pass-file .ansible-vault -i $WORKDIR/ansible-haproxy/test/debian_inventory.yml $WORKDIR/ansible-haproxy/test/system_simple_playbook.yml $@

# Clean Up
rm -rf $WORKDIR
