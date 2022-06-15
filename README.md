# Git Autocommit

This program allows you to connect automatically push code to github repo of your choice

## Usage

### Requirements

To use this program you need:

- GIT(with no need for credentials on push)
- A repo with unstaged files

### All-in-one method

To use this program you just need an initial configuration. After that, you just have to sit down and watch
everything being pulled automatically. Below is the ordered list of steps you must follow to get all working:

1. [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) or [add remotely](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories) to pull the new repository locally in your machine.
2. Add the full path to the repo you want to commit the files and save it as `TARGETFOLDER='repo/to/be/auto/committed'` inside your .bashrc(or .zshrc) files.
4. Type `crontab -e` and add this line `* * * * * /usr/bin/bash /folder/of/this/repo/autocommiter.sh`, it will run every minute, you can customize the frequency [here](https://crontab.guru).
5. Run `service cron status` to check if cron is active, if not `service cron start` to start it.
6. The script is now running a log is kept in `/autocommiter_tracker`.

## Ideas

I plan to add some customizations, glob pattern to choose files, multiple files/commits a day.