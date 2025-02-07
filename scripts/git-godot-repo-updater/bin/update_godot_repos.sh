#!/bin/bash

echo ""
echo -e "Clearing safe directory list...\n"

# Unset all safe directories
git config --global --unset-all safe.directory

# Get the working directory and add essential directories to safe.list
if [[ "$(pwd)" =~ ^/mnt/[a-z]/ ]]; then
    # For WSL, convert the Linux-style path to Windows-style
    working_directory=$(pwd -W | sed 's/^\/mnt\/\([a-z]\)/\1:/')
else
    # For non-WSL or Linux/macOS, use the regular path
    working_directory=$(pwd)
fi
echo "Working Directory: $working_directory"  # Debug output

# Add relevant directories to safe.directory
git config --global --add safe.directory "$working_directory"
git config --global --add safe.directory "$working_directory/Godot/"
git config --global --add safe.directory "$working_directory/Godot/Projects/"

# Iterate over all directories in the Godot/Projects directory
for dir in "$working_directory/Godot/Projects/"*; do
    # echo "Checking directory: $dir"  # Debug output
    if [ -d "$dir" ]; then
        echo -e "Git repository found in: $dir"
        echo -e "Adding $dir to the safe directory list.\n"
        
        git config --global --add safe.directory "$dir"
        
        # Use pushd/popd to safely navigate between directories
        pushd "$dir" > /dev/null
        
        echo "Checking status of repository..."
        git status -s -b
        echo ""

        echo "Checking for updates on the remote repository..."
        git fetch

        UPSTREAM=${1:-'@{u}'}
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse "$UPSTREAM")
        BASE=$(git merge-base @ "$UPSTREAM")

        if [ "$LOCAL" = "$REMOTE" ]; then
            echo "$dir is up-to-date."
        elif [ "$LOCAL" = "$BASE" ]; then
            echo "$dir is behind the remote repository. Pulling changes..."
            git pull
        elif [ "$REMOTE" = "$BASE" ]; then
            echo "$dir has unpushed changes."
        else
            echo "$dir and remote repositories have diverged."
        fi

        # Return to the original directory
        popd > /dev/null
    else
        # echo "No Git repository found in: $dir"  # Debug output
    fi
done

# Return to the original directory
cd "$working_directory/"
