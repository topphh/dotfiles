#!/bin/bash

DEST_DIR="$HOME/.config"
mkdir -p "$DEST_DIR"

# Loop through all folders inside ./config/
for config in "$(realpath "./")"/*; do
    echo "config: $config"
    # Only process directories
    [ -d "$config" ] || continue

    folder=$(basename "$config")
    dest="$DEST_DIR/$folder"

    if [ -L "$dest" ]; then
        echo "Symlink already exists: $dest -> $(readlink -f "$dest")"
    elif [ -e "$dest" ]; then
        echo "Error: $dest already exists and is not a symlink."
    else
        ln -s "$config" "$dest"
        echo "Created symlink: $dest -> $config"
    fi
done
