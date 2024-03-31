 tables=(users  orders  products  order_items  promos  addresses  events)
 for table in ${tables[@]}; do
   #echo  "models/staging/postgres/stg_postgres__${table}.sql"
   echo  "  - name:  stg_postgres__${table}"
   #touch "models/staging/postgres/stg_postgres__${table}.sql"
done