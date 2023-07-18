# Bash Tools

## Backup Scripts

Scripts for backup files and MySQL databases.

- [backup.files.sh](backup.files.sh)
  - `-d 'DIR_1;DIR_2;DIR_3'`  
    Directory list.
- [backup.mysql.sh](backup.mysql.sh)
  - `-u 'USER'`  
    MySQL user name.
  - `-p 'PASSWORD'`  
    MySQL user password.
  - `-d 'DB_1;DB_2;DB_3'`  
    MySQL database list.

### Syntax

```sh
./backup.files.sh -d '/home/dir_1;/home/dir_2;/home/dir_3'
```

- Backup directories `dir_1`, `dir_2` and `dir_3`.

```sh
./backup.mysql.sh -u 'db_user' -p 'db_password' -d 'db_name_1;db_name_2;db_name_3'
```

- Backup databases `db_name_1`, `db_name_2` and `db_name_3` with username `db_user` and password `db_password`.
