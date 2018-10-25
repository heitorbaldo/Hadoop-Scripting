
#moved from mysql to HDFS

!/bin/bash 

    TABLENAME=${^^1} 
    HDFSPATH=${^^2} 
    NOW=$(date +"%m-%d-%Y-%H-%M-%S") 

    sqoop --import --connect jdbc:db2://mystsrem:60000/SCHEMA \
     --username username \
     --password-file password \
     --query "select * from ${TABLENAME} \$CONDITIONS" \
     -m 1 \
     --delete-target-dir \
     --target-dir ${HDFSPATH} \
     --fetch-size 30000 \
     --class-name ${TABLENAME} \
     --fields-terminated-by '\01' \
     --lines-terminated-by '\n' \
     --escaped-by '\' \
     --verbose &> logonly/${TABLENAME}_import_${NOW}.log