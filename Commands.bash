-- Show all processes for PostgreSQL
ps -o pid,command --ppid `head -n 1 $PGDATA/postmaster.pid`

