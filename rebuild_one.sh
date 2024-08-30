#!/bin/bash

# Check if a container name was provided as a parameter
if [ -z "$1" ]; then
    echo "Error: No container name provided."
    echo "Usage: $0 <container_name>"
    exit 1
fi

# Assign the provided container name to a variable
container_name=$1

# Stop the specified container
sudo docker compose stop "$container_name"

# Remove the specified container
sudo docker compose rm -f "$container_name"

# Store the starting directory
start_dir=$(pwd)

# Find and update all Git repositories in subdirectories
find . -type d | while read dir; do
    if [ -d "$dir/.git" ]; then
        echo "Updating $dir"
        (cd "$dir" && git pull)
        cd "$start_dir"
    fi
done

# Rebuild and start only the specified container
sudo docker compose up --build -d "$container_name"
