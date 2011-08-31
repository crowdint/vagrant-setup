UPDATE pg_database SET datallowconn = TRUE
WHERE datname = 'template0';

\c template0

UPDATE pg_database SET datistemplate = FALSE
WHERE datname = 'template1';

DROP database template1;

CREATE database template1 WITH template = template0
ENCODING = 'unicode' LC_CTYPE='en_US.utf8' LC_COLLATE='en_US.utf8';

UPDATE pg_database SET datistemplate = TRUE
WHERE datname = 'template1';

\c template1

UPDATE pg_database SET datallowconn = FALSE
WHERE datname = 'template0';

VACUUM FULL FREEZE;
