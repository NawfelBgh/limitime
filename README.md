# limitime

limit users' sessions time

## Intallation

Before installing, the group `admin` must be created

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

Any member of the groupe `admin` can manage files inside `consumed`
and `limits`

The installation also adds a cron job which executes `limitime.sh` every minute

## Usage

### Note

This section is for the members of the `admin` group. No root privileges are required

To limit the user `foo` login time to 60 minutes on Monday, 50 minutes on Friday and 30 minutes on the other
days of the week, create a file called `foo` in the directory `limits` with the content:

    60
    30
    30
    30
    50
    30
    30

A blank line means INFINITY, numbers prepended with a zero are interpreted in octal.

When the user `foo` logs on, a file will be created in the directory `consumed` , with the name `foo`,
containing the amount of time (in minutes) consumed by that user during the same day.

Any user can read the content of the files inside `limits` and `consumed`, so that users can know
how match remaining time they have.

### Notifying users

The script `limitime-notify.sh` can be executed by any user. It notifies that user when less than
N minutes are left. For notification it uses `send-notify`.

```sh
    limitime-notify.sh N # Notify the user when he has N minutes remaining
    # N is optional. It defaults to 5
```

## Compatibility

Tested to work on Lubuntu 14.04.1 and Fedora 20.
But in Lubuntu, `send-notify` was not available, so `limitime-notify.sh` didn't work
