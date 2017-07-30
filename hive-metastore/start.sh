#!/bin/bash
set -x
service mysql start

# restart ssh daemon
/usr/sbin/sshd &

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    # force safemode leave
    hdfs dfsadmin -safemode leave
done

/usr/lib/hive/bin/schematool -dbType mysql -initSchema

service hive-metastore start
/etc/init.d/daemon hive-metastore &
sleep 20
#check if new migrations are present
HIVE_MIGRATIONS=/usr/lib/hive/hive_migrations
last_migration=$(cat $HIVE_MIGRATIONS/.migration_info)
current_last_migration=$(cd $HIVE_MIGRATIONS && ls *.sql | sort | tail -n 1)
if [ "$last_migration" != "$current_last_migration" ]; then
    (cd $HIVE_MIGRATIONS
        (
            cat .migration_info && (
                last_checkpoint=$(cat .migration_info)
                echo "Last checkpoint exists"
                #when last checkpoint exists
                ls | sort | xargs | grep -o $(cat .migration_info).* | xargs -n 1 | sed 1,1d | xargs cat > ../big.sql
                mv ../big.sql big.sql
                hive -f big.sql || echo "running migrations failed"
                cat big.sql
                rm -rf big.sql
                new_last_migration=$(cd $HIVE_MIGRATIONS && ls *.sql | sort | tail -n 1)
                echo $new_last_migration > .migration_info
            )
        )||(
            echo "Last checkpoint does not exists"
            #when no last checkpoint present, running script first time
            rm -rf big.sql
            cat * > big.sql
            hive -e "CREATE DATABASE pam;" || echo "database pam already exists"
            hive -f big.sql || echo "running migrations failed"
            rm -rf big.sql
            new_last_migration=$(cd $HIVE_MIGRATIONS && ls *.sql | sort | tail -n 1)
            echo $new_last_migration > .migration_info
        )
    )
fi

tail -f `find /var/log -name *.log -or -name *.out`
