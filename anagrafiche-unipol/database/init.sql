-- ----------------------------------------------------------------------
--
-- Sample commands to init database for TAS FIN solution using PostgreSQL
-- 'psql' command line interface. Customize it to suit your needs.
--
-- ----------------------------------------------------------------------
 
--
-- Create roles
--
--CREATE ROLE db_owner LOGIN PASSWORD 'db_owner' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
--CREATE ROLE db_user LOGIN PASSWORD 'db_user' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
\echo 'Creating roles: db_owner, db_user';
CREATE ROLE "db_owner" LOGIN PASSWORD 'db_owner' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
CREATE ROLE "db_user" LOGIN PASSWORD 'db_user' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
--
-- Create and connect to Database
--
--CREATE DATABASE database OWNER db_owner ENCODING = 'UTF8' TABLESPACE DEFAULT;
--GRANT ALL ON DATABASE database to db_owner;
\echo 'creating database';
CREATE DATABASE database OWNER "db_owner" ENCODING = 'UTF8' TABLESPACE DEFAULT;
\echo 'granting all on database database to db_owner';
GRANT ALL ON DATABASE database to "db_owner";

\echo 'Connecting to database';
\connect database

--
-- Create schemas and assign grants
--
GRANT USAGE ON SCHEMA public TO "db_user";

--COMMIT;
--\echo 'Committed!';
-- EOF
