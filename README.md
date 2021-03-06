Streamline
==========
Your favorite music streaming website. 
Implemented with Python Django and PostgreSQL.


Login Credentials
-----------------
**UserID:Password**
~~~
dog@dog.com:12345
cat@cat.com:12345
~~~


MAC SETUP
-----------

###  1. DEPENDENCIES INSTALLATION:
1. Install Python 3. Make sure you have PIP as well.
2. Install PostgreSQL 10 : https://postgresapp.com
3. Install Django 2. In terminal:
```
pip3 install django
```
4. Install psycopg2. In terminal:
```
pip3 install psycopg2
```
###  2. SET UP STREAMLINE DATABASE

1. In Terminal: type 'psql'
2. In PostgreSQL terminal session. Run prepare_script.sql. This will create a new user sl_admin and the database. 
```
your_username=#  \i path/to/file/streamline/prepare_script.sql
```

3. Type \q to quit psql

4. Sign back in again using the User you just created in prepare_script.sql.
This is important because PostgreSQL is very restricted in terms of database Owners.

In terminal: 
```
psql -d streamline_db -U sl_admin
```

5. Create tables and insert data:
```
streamline_db=> \i /path/to/file/streamline/create_database_script.sql
streamline_db=> \i /path/to/file/streamline/insert_all_data.sql
```

###  3. RUN WEBSITE

1. cd to streamline directory
2. Run migration to create Django-specific tables in your database

```
python3 manage.py migrate
```
3. Run server
```
python3 manage.py runserver
```
4.  In a web browser, navigate to login page:
```
http://127.0.0.1:8000/login
```
Welcome to Streamline!


WINDOWS SETUP
---------------

### 1.DEPENDENCIES INSTALLATION:

Install Python (3.5) and PyCharm
```
https://www.jetbrains.com/pycharm/download/#section=windows
```

Execute the following commands in PowerShell/cmd:
```
pip install -U pip
pip install django
pip install psycopg2
```

NOTE: You may require Visual Studio 10 and/or .NET Framework 4.



### 2.RUNNING THE DATABASE:

In PowerShell/cmd, browse to the PostgreSQL installation directory. 
Windows 10 default is C:\Program Files\PostgreSQL

Go to the \data directory and edit the pg_hba.conf file, changing all the 'md5' to 'trust':

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
# Allow replication connections from localhost, by a user with the
# replication privilege.
host    replication     all             127.0.0.1/32            trust
host    replication     all             ::1/128                 trust
```

The following commands setup the database in order as described:

1. Create user sl_admin with appropriate privileges
```
./psql --username=postgres -f <path_to_file>\streamline\prepare_script.sql
```
2. Create all tables for the database with the created user 'sl_admin'
```
./psql --username=sl_admin -f <path_to_file>\streamline\create_database_script.sql streamline_db
```
3. Populate tables with data
```
./psql --username=sl_admin -f <path_to_file>\streamline\insert_all_data.sql streamline_db
```


### 3. ACCESSING WEBSITE:

In PyCharm, go to the terminal view cd to the project file directory, then run migration to create Django-specific tables in your database:
```
python manage.py migrate
python manage.py runserver
```

You can access the website by going to your browser and entering in the following:
```
http://127.0.0.1:8000/login
```



### 4. RUNNING SQL QUERIES:


OPTION 1: USING POSTGRESQL GUI

Open pgAdmin 4 that was installed along with PostgreSQL
```
Tools -> Query Tool
```

Type/copy-paste the desired query
Press 'F5' or the lightening bolt symbol to execute query



OPTION 2: COMMAND LINE

Login as DB admin:
```
./psql -d streamline_db -U sl_admin
```

Execute queries (Don't forget the semicolon! Query will not execute without it unlike in DBeaver):
```
SELECT * FROM album;
```

If you want to run a .sql file with multiple queries in them:
```
./psql --username=sl_admin -f <path_to_file>/streamline/<filename>.sql streamline_db
```



###  5. RESETTING

If you ever need to reset the entire program and the database, follow these steps:

```
cd <PostgreSQL_directory>\bin
./psql --username=postgres


DROP OWNED BY sl_admin;
DROP USER IF EXISTS sl_admin;
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
\q


./psql --username=postgres -f <path_to_file>\streamline\prepare_script.sql
./psql --username=sl_admin -f <path_to_file>\streamline\create_database_script.sql streamline_db
./psql --username=sl_admin -f <path_to_file>\streamline\insert_all_data.sql streamline_db


cd <streamline_directory>
python manage.py migrate
python manage.py runserver
```

Then access the website via the link:
```
http://127.0.0.1:8000/login
```
