#!/bin/bash

echo ""
echo -e "Clearing safe directory list...\n"

# Unset all safe directories
git config --global --unset-all safe.directory

# Get the working directory and add essential directories to safe.list
if [[ "$(pwd)" =~ ^[A-Za-z]:\\ ]]; then
    # Get the drive letter for Windows paths and avoid leading '/'
    working_directory=$(pwd -W | sed 's/^\([A-Z]\):.*/\1:/')
else
    # For Linux or macOS paths, just get the parent directory
    working_directory=$(dirname "$(pwd)")
fi

# Add safe directories
git config --global --add safe.directory "$working_directory"
git config --global --add safe.directory "$working_directory/Godot"
git config --global --add safe.directory "$working_directory/Godot/Projects"

# Iterate over all directories in the Godot/Projects directory
for dir in "$working_directory/Godot/Projects/"*; do
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
    fi
done

# Return to the original directory
cd "$working_directory/"