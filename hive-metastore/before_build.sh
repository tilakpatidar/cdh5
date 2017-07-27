#!/usr/bin/env bash

REPOSRC=https://github.com/gruppopam/lake_garda.git
LOCALREPO=lake_garda

LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    git clone $REPOSRC $LOCALREPO
else
    (cd $LOCALREPO && git pull $REPOSRC)
fi

cp lake_garda/migrations/src/main/db/migrations/*.sql hive_migrations/
rm -rf hive_migrations/.migration_info
