# Update Godot Project Git Repositories Script

## Description:

This Bash script automates the process of checking and updating all Git repositories within your Godot projects directory. It is designed under the assumption that you, as a developer, may be working on your Godot projects from different workstations, but want to keep all of your workstations up to date on the current states of your various projects. The script performs the following tasks:

- Clears Git's safe directory list (not strictly necessarily, but helps keep the list clean).
- Sets up Git's safe directory list to include all relevant directories.
- Iterates through all the directories in the `Godot/Projects/` directory looking for Git repositories.
- For each repository found:
  - Checks the status of the repository.
  - Fetches the latest updates from the remote repository.
  - Compares the local and remote branches to determine if there are:
    - No changes (repository is up-to-date).
    - Changes that need to be pulled (repository is behind).
    - Local changes that need to be pushed (unpushed changes).
    - Divergence between the local and remote branches.
- Once the script completes, it provides a summary of the repository's status and ensures that all repositories are updated accordingly.

## Prerequisites:
- This script assumes you have a `Godot/Projects/` directory

## Installation & Setup:
- Copy the script in the `bin/` directory to the directory where your `Godot/Projects/` directory exists.
- Ensure update_godot_repos.sh has permission to execute:
  - `chmod +x update_godot_repos.sh`
- Run the script:
  - `update_godot_repos.sh`

## License:
This project is licensed under the MIT License.

## Feedback/Questions:
If you have any questions or suggestions for improvement, feel free to open an issue in this repo. I’d be happy to help!

