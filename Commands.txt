-- Show all processes
ps -o pid,command --ppid `head -n 1 $PGDATA/postmaster.pid`

