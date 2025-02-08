# Database Startup Script

## Description:
This Bash script automates the process of:

- Switching to the user profile that controls the Oracle database (`oracle` user).
- Starting the Oracle database.
- Displaying the IP address of the database server.

Once the script completes, it logs out the `oracle` user and returns you to the original user.

Additionally, the repository contains a `.bashrc.d` directory with an alias script, automatically creating an alias (`startdb`) for running the script more easily.

## Prerequisites:
- The script assumes that you have an **Oracle Linux** server with the `oracle` user configured. If the `oracle` user doesn't exist or you use a different user, you'll need to adjust the script accordingly.
- The **Oracle Database** must be properly installed and configured on the system.

## Installation & Setup:

- Copy the contents of the `/bin` directory into your Oracle Linux profile home directory.
- Upon opening a new session in Oracle Linux, if your shell automatically scans the `/.bashrc.d` directory for files, the alias will be created automatically, and you can use the startdb command to run the script.
  - If your shell **doesn't** automatically scan the `/.bashrc.d` directory for files, manually copy the alias setup script into your profile's `~/.bashrc` file.

## Feedback/Questions:
If you have any questions or suggestions for improvement, feel free to open an issue in this repo. I’d be happy to help!
