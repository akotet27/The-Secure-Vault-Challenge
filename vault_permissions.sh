#!/bin/bash

# Secure Vault Challenge - Step 2: Vault Permissions
# This script manages file permissions for the secure vault

# Check if secure_vault exists
if [ ! -d ~/secure_vault ]; then
    echo "Error: secure_vault directory does not exist."
    exit 1
fi

# Function to ask about and update permissions
update_permission() {
    local file=$1
    local default_perm=$2
    local filepath=~/secure_vault/$file
    
    echo ""
    echo "File: $file"
    echo "Current permissions:"
    ls -l "$filepath"
    
    echo -n "Do you want to update the permission for $file? (yes/no or press Enter for default: $default_perm): "
    read response
    
    # If empty input, apply default permissions
    if [ -z "$response" ]; then
        echo "Applying default permission: $default_perm"
        chmod $default_perm "$filepath"
    elif [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        echo -n "Enter new permission (e.g., 600): "
        read perm
        if [ -n "$perm" ]; then
            chmod $perm "$filepath"
            echo "✓ Permission updated to $perm"
        fi
    else
        echo "Permission left unchanged"
    fi
}

# Process each file with default permissions
update_permission "keys.txt" "600"
update_permission "secrets.txt" "640"
update_permission "logs.txt" "644"

# Display all final permissions
echo ""
echo "==============================="
echo "Final File Permissions:"
echo "==============================="
ls -l ~/secure_vault/
