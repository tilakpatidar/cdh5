FROM postgres:9.5

#add scripts to be executed after postgres starts
ADD init.sh /docker-entrypoint-initdb.d/init.sh
RUN mkdir -p /docker-entrypoint-initdb.d &&\
     chmod 755 /docker-entrypoint-initdb.d/init.sh &&\
     chown root:root /docker-entrypoint-initdb.d/init.sh