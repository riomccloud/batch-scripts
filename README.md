# Batch scripts
Personal collection of Windows batch scripts that do a multitude of tasks.

## frogbackup.bat
My personal semi-automatic backup utility that uses [restic](https://github.com/restic/restic) and [rclone](https://github.com/rclone/rclone) as the backend. By default configured to 3 cloud storage services (one without restic, no encryption) and a external storage drive. Asks for password every time, and restic-powered backups keep only the last 7 snapshots (12 in total by default, since it backups two folders).

You'll need to change paths and other values to make the script work in your scenario. You're free to add and remove backup instances, and change configuration values. The texts and variables are written in Portuguese, so maybe you'll need help to understand them. :P
