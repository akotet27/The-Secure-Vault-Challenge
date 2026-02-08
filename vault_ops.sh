#!/bin/bash

# Secure Vault Challenge - Step 3: Vault Operations
# This script provides a menu-driven interface for vault operations

VAULT_DIR=~/secure_vault
SECRETS_FILE=$VAULT_DIR/secrets.txt
KEYS_FILE=$VAULT_DIR/keys.txt
LOGS_FILE=$VAULT_DIR/logs.txt

# Main menu loop
while true; do
    echo ""
    echo "================================"
    echo "      SECURE VAULT MENU"
    echo "================================"
    echo "1. Add Secret"
    echo "2. Update Secret"
    echo "3. Add Log Entry"
    echo "4. Access Keys"
    echo "5. Exit"
    echo "================================"
    echo -n "Select an option (1-5): "
    read choice
    
    case $choice in
        1)
            # Add Secret
            echo -n "Enter the secret to add: "
            read secret
            if [ -n "$secret" ]; then
                echo "$secret" >> $SECRETS_FILE
                echo "✓ Secret added successfully"
            else
                echo "✗ No secret provided"
            fi
            ;;
        2)
            # Update Secret
            echo -n "Enter the text to find: "
            read find_text
            echo -n "Enter the replacement text: "
            read replace_text
            
            # Check if match exists
            if grep -q "$find_text" $SECRETS_FILE; then
                sed -i "s/$find_text/$replace_text/g" $SECRETS_FILE
                echo "✓ Secret updated successfully"
            else
                echo "No match found."
            fi
            ;;
        3)
            # Add Log Entry
            echo -n "Enter log message: "
            read log_message
            if [ -n "$log_message" ]; then
                timestamp=$(date '+%Y-%m-%d %H:%M:%S')
                echo "[$timestamp] $log_message" >> $LOGS_FILE
                echo "✓ Log entry added"
            else
                echo "✗ No log message provided"
            fi
            ;;
        4)
            # Access Keys - Always deny
            echo "ACCESS DENIED 🚫"
            ;;
        5)
            # Exit
            echo "Exiting Secure Vault. Stay secure!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select 1-5."
            ;;
    esac
done
