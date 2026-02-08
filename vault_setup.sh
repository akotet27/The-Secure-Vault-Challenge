#!/bin/bash

# Secure Vault Challenge - Step 1: Vault Setup
# This script creates the secure_vault directory with initial files

# Create the secure_vault directory in home
mkdir -p ~/secure_vault

# Add welcome messages to each file using I/O redirection
echo "=== Encryption Keys Storage ===" > ~/secure_vault/keys.txt
echo "This file stores encryption keys for the vault." >> ~/secure_vault/keys.txt

echo "=== Confidential Data Storage ===" > ~/secure_vault/secrets.txt
echo "This file stores secret information." >> ~/secure_vault/secrets.txt

echo "=== System Logs ===" > ~/secure_vault/logs.txt
echo "This file stores system activity logs." >> ~/secure_vault/logs.txt

# Print success message
echo "✓ Secure Vault Successfully Created!"
echo "✓ All files initialized with welcome messages"
echo ""
echo "File listing (long format):"
ls -l ~/secure_vault/
