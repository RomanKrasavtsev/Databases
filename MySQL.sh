mysqldump -u username -p DB --ignore-table=db.table | gzip > `date +/backup/%Y%m%d_%H%M%S_db.sql.gz`

 
