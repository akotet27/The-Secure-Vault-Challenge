#!/bin/bash

# Secure Vault Challenge - Step 4: Vault Monitoring
# This script monitors vault files and creates a security report

VAULT_DIR=~/secure_vault
REPORT_FILE=$VAULT_DIR/vault_report.txt

# Create the report
{
    echo "===================================="
    echo "   SECURE VAULT SECURITY REPORT"
    echo "===================================="
    echo "Generated at: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    # Check if vault directory exists
    if [ ! -d "$VAULT_DIR" ]; then
        echo "Error: Secure vault directory not found!"
        exit 1
    fi
    
    # Initialize security risk flag
    RISK_DETECTED=false
    
    # Process each file in secure_vault
    for file in $VAULT_DIR/{keys.txt,secrets.txt,logs.txt}; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            filesize=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
            lastmodified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$file" 2>/dev/null || stat -c "%y" "$file" 2>/dev/null | cut -d. -f1)
            permissions=$(ls -l "$file" | awk '{print $1}')
            
            echo "File: $filename"
            echo "  Size: $filesize bytes"
            echo "  Last Modified: $lastmodified"
            echo "  Permissions: $permissions"
            
            # Extract octal permissions (last 3 digits)
            octal_perm=$(stat -f "%A" "$file" 2>/dev/null || stat -c "%a" "$file" 2>/dev/null)
            
            # Check if permissions are more open than 644
            if [ "$octal_perm" -gt "644" ]; then
                echo "  ⚠️ SECURITY RISK DETECTED - Permissions too open ($octal_perm)"
                RISK_DETECTED=true
            fi
            
            echo ""
        fi
    done
    
    # Final security summary
    echo "===================================="
    if [ "$RISK_DETECTED" = true ]; then
        echo "SECURITY STATUS: ⚠️ RISKS DETECTED"
    else
        echo "SECURITY STATUS: ✓ SECURE"
    fi
    echo "===================================="
    
} > "$REPORT_FILE"

# Print confirmation
echo "✓ Vault report successfully created at: $REPORT_FILE"
echo ""
echo "Report contents:"
cat "$REPORT_FILE"
