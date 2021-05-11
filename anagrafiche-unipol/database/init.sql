CREATE TABLESPACE "TS_INDEX"
    LOCATION '/var/lib/postgresql/TS_INDEX';
CREATE TABLESPACE "TS_DATA"
    LOCATION '/var/lib/postgresql/TS_DATA';


CREATE USER DB_OWNER PASSWORD 'DB_OWNER';
CREATE USER DB_USER PASSWORD 'DB_USER';

GRANT ALL PRIVILEGES ON DATABASE postgres TO DB_USER;
GRANT ALL PRIVILEGES ON DATABASE postgres TO DB_OWNER;