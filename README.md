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
2. Run `sudo nano /etc/environment` and save these 2 fullpaths `TARGETFOLDER="/home/folders/myprojectsfolder/target"` and `AUTOCOMMITFOLDER="/home/folders/myprojectsfolder/autocommit"`
3. Once inside this repo run `chmod +x ./autocommit.sh` to make sure it is an executable and it can be used by a cron.
4. Type `crontab -e` and add this line `* * * * * /home/myprojectsfolder/autocommit/autocommit.sh >> /var/log/cron.log 2>&1`, it will run every minute, you can customize the frequency [here](https://crontab.guru).
5. Run `service cron status` to check if cron is active, if not `service cron start` to start it.
6. The script is now running a log is kept in `./autocommit_tracker`.

NB
If your cron has never been configured make sure there are right permissions in place.


To enable a cron.log file to monitor entries uncomment `cron` in `/etc/rsyslog.d/50-default.conf` and make sure `var/log` and `cron.log` have the right permissions.

Then typing `tail -f /var/log/cron.log` will allow you to monitor cron.

## Ideas

I plan to add some customizations, glob pattern to choose files, multiple files/commits a day.