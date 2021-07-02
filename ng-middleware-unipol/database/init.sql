

\echo 'Creating roles: db_owner, db_user';
CREATE ROLE "db_owner" LOGIN PASSWORD 'db_owner' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
CREATE ROLE "db_user" LOGIN PASSWORD 'db_user' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

\echo 'creating database';
CREATE DATABASE "DATABASE" OWNER "db_owner" ENCODING = 'UTF8' TABLESPACE DEFAULT;
\echo 'granting all on database database to db_owner';
GRANT ALL ON DATABASE "DATABASE" to "db_owner";

\echo 'Connecting to database';
\connect "DATABASE"

GRANT USAGE ON SCHEMA public TO "db_user";