# backup-to-nas

This script is what I use to rsync my homedir to my NAS.

The `excludes` file is used to tell rsync to skip things that don't make sense to backup.

Symlinking this stuff into the homedir is skipped by default. The expected case is to move the following:

* `backup-to-nas`: `~/.local/bin/backup-to-nas`
* `excludes`: `~/.config/backup-to-nas/excludes`

Symlinking these files from this repo allows them to stay in sync with the latest version automatically, and that's what I do.
