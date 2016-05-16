-- ### FILES ###

-- Show path to config
SHOW config_file;

-- Show path to hba 
SHOW hba_file;

-- Read file
select * from regexp_split_to_table(pg_read_file('filename'))

-- ### MONITORING ###

-- Show top 5 query from execution statistics
-- Do not forget to add pg_stat_statements
-- to shared_preload_libraries in postgresql.conf
-- and restart server
select
  md5(query),
  calls,
  total_time,
  rows,
  shared_blks_hit,
  shared_blks_read,
  (total_time / calls) as avg_time
from pg_stat_statements
order by avg_time desc
limit 5;

-- Show a specific query statement from execution statistics
select
  query
from pg_stat_statements
where md5(query) in ('1', '2', '3');

-- Show current queries sorted by time
select now() - query_start, procpid, current_query
from pg_stat_activity 
where current_query <> '<IDLE>'
order by 1 desc;

-- It is very useful to use pg_stat_kcache
-- See more https://github.com/dalibo/pg_stat_kcache

SELECT datname, queryid, round(total_time::numeric, 2) AS total_time, calls,
  pg_size_pretty((shared_blks_hit+shared_blks_read)*8192 - reads) AS memory_hit,
  pg_size_pretty(reads) AS disk_read, pg_size_pretty(writes) AS disk_write,
  round(user_time::numeric, 2) AS user_time, round(system_time::numeric, 2) AS system_time
FROM pg_stat_statements s
  JOIN pg_stat_kcache() k USING (userid, dbid, queryid)
  JOIN pg_database d ON s.dbid = d.oid
WHERE datname != 'postgres' AND datname NOT LIKE 'template%'
ORDER BY total_time DESC
LIMIT 10;

select query pg_stat_statments where queryid in (1, 2, 3);

-- Show table statistic
select * from pg_stat_all_tables
where relid='TABLENAME'::regclass;

-- Show function statistics
select * from pg_stat_user_functions;

-- Show statements in log
alter system set "log_line_prefix" = "!!! pid=%p";
alter system set "log_duration" = "on";
alter system set "log_statement" = "on";

-- ### RELOAD CONFIGURATION FILES ###

-- Reload configuration files
select pg_reload_conf()

-- ### BLOCKED PROCESSES ###

-- Show blocked processes
select * from pg_stat_activity where waiting;

-- Show ungranted locks
select locktype, transactionid, pid, mode, granted
from pg_locks where pid = PID and not granted;

-- Show blocking process
select locktype, transactionid, pid, mode, granted
from pg_locks where transactionid = TRANSACTIONID and granted;

-- ### KILL ###

-- Terminate process
select pg_terminate_backend(PID);

-- Cancel query
select pg_cancel_backend(PID);

-- ### SIZE ###

-- Show table size
select pg_size_pretty(pg_total_relation_size('TABLE_NAME'));

-- Show DB size

