# users and privileges
select * from information_schema.user_privileges;

# PROCESSLIST
SHOW FULL PROCESSLIST

# current queries
SELECT 
  id,
  state,
  command,
  time,
  info
FROM information_schema.processlist
WHERE command <> 'Sleep' 
AND info NOT LIKE '%PROCESSLIST%'
ORDER BY time DESC LIMIT 50;

# Size of databases
SELECT
  table_schema as "db",
  Round(Sum(data_length + index_length) / 1024 / 1024, 1) as "size, MB" 
FROM information_schema.tables 
GROUP BY table_schema
ORDER by 2 DESC;

# Size of tables
SELECT
  table_schema as 'db', 
  table_name as 'table', 
  round(((data_length + index_length) / 1024 / 1024), 2) 'size, MB' 
FROM information_schema.TABLES 
ORDER BY 3 DESC;

# Number of connections
SHOW status WHERE variable_name = "Threads_connected";
