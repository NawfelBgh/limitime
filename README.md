# limitime

This program lets you define time limits to the users of a linux machine.
It launchs a task (cron job) which looks every minute for logged on users and logs them out
if they have exceeded their limits. A user can still login after being logged out but will be
logged out again when this program checks in the next minute.

This program doesn't have a GUI. It is configurable via simple plain text files.

## Intallation

Before installing, create a group named `admin` and run `install.sh` with root privileges.

```sh
    install.sh DIRECTORY # install in DIRECTORY
    # DIRECTORY is optional, it defaults to /limitime

    uninstall.sh DIRECTORY # uninstall from DIRECTORY
    # DIRECTORY is optional, it defaults to /limitime
```

Installing in `/limitime` for example creates this directory tree:

    /limitime/
    ├── consumed
    ├── limitime-notify.sh
    ├── limitime.sh
    └── limits

    2 directories, 2 files

where:

    $ ls -l
    drw-rwsr--. 2 root admin 4096 Aug 26 14:05 consumed
    -r-xr-xr-x. 1 root root   726 Aug 26 14:05 limitime-notify.sh
    -r-xr-xr-x. 1 root root  1455 Aug 26 14:05 limitime.sh
    drw-rwsr--. 2 root admin 4096 Aug 26 14:05 limits

Members of the groupe `admin` can manage files inside the directories `consumed` and `limits`.

The installation also adds a cron job which executes `limitime.sh` every minute.

## Usage

### Administrators

*This section is for the members of the `admin` group. No root privileges are required*

Here is an example of how to limit the login time of a user named `foo`.
Imagine we want him to be able to use the computer 60 minutes on Monday, 50 minutes on Friday and 30 minutes on the other
days of the week.

To do that, create a file called `foo` in the directory `limits` with the content:

    60
    30
    30
    30
    50
    30
    30

As you have probably noticed, the first line of the file defines the permited login time for Monday,
the second line is for Tuesday, ..., and the last line is for Sunday.

The absense of the file `limits/foo` means that no restrictions are defined for the user `foo`.
A blank line in that file means INFINITY. And numbers prepended with a zero are interpreted in octal.

This program will then maintain the amount of time (in minutes) consumed by the user `foo` 
during the same day in the directory `consumed/foo`.

The permission are set so that all users can read the content of the files inside `limits` and `consumed`.

### Regular users

*This section is for users with limited time who want to be notified before they are logged out*

The script `limitime-notify.sh` can be executed by any user. It notifies him when less than
N minutes are left. For notification it uses `send-notify`.

```sh
    limitime-notify.sh N # Notify the user when he has N minutes remaining
    # N is optional. It defaults to 5
```

To automate the execution of `limitime-notify.sh` at session startup, you can [add it as a startup application](http://askubuntu.com/questions/178567/how-to-add-a-program-as-startup-application-from-terminal)

## Credit

This program is modeled after [this explanation](http://forums.linuxmint.com/viewtopic.php?f=47&t=72317&start=0). Thank you Pilosopong Tasyo!

## Compatibility

Tested to work on Lubuntu 14.04.1 and Fedora 20.

In Lubuntu, I needed to install `send-notify` since it was not installed by default.
