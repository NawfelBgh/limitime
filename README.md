# limitime

limit users' sessions time

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

    drw-rwSr--. 2 root admin 4096 Aug 26 14:05 consumed
    -rwxr-xr-x. 1 root root   726 Aug 26 14:05 limitime-notify.sh
    -rwxr-xr-x. 1 root root  1455 Aug 26 14:05 limitime.sh
    drw-rwSr--. 2 root admin 4096 Aug 26 14:05 limits

Any member of the groupe `admin` can manage files inside `consumed`
and `limits`

The installation also adds a cron job which executes `limitime.sh` every minute

## Usage

### Note

This section is for the members of the `admin` groupe. No root privileges are required

To limit the user `foo` login time to 60 minutes on Monday, 50 minutes on Friday and 30 minutes for the other
days of the week, create a file called `foo` in the directory `limits` with the content:

    60
    30
    30
    30
    50
    30
    30

When the user `foo` logs on, a file will be created in the directory `consumed` , with the name `foo`,
containing the amount of time (in minutes) consumed by that user.

Any user can read the content of the files inside `limits` and `consumed`, so that users can know
how match remaining time they have.

The script `limitime-notify.sh` can be executed by any user. It notifies that user when less than
5 minutes are left. For notification it uses `send-notify`.
