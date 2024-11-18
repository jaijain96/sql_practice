# sql_practice

start sql server on local macos machine using these steps:

1. check whether sql server is running on local machine or not using htop and then filtering using F4 -> mysql

2. if an existing process is running, restart mysql using:

    ```bash
    mysql.server restart
    ```

    else,
    run mysql using;

    ```bash
    mysql.server start
    ```

    re-check htop post this

3. attempt connecting to mysql using:

    ```bash
    mysql -u root
    ```

if still not working, refer: <https://stackoverflow.com/questions/15450091/error-2002-hy000-cant-connect-to-local-mysql-server-through-socket-tmp-mys>
