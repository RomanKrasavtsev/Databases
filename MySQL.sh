# Dump
mysqldump -u username -p DB --ignore-table=db.table | gzip > `date +/backup/%Y%m%d_%H%M%S_db.sql.gz`

# User and password from config
mysql_config_editor set --login-path=local --host=localhost --user=localuser --password
mysql --login-path=local -e "statement"
