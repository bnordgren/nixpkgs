#!/bin/sh
sql_files=(@sql_srcs@)

do_help(){ echo "$0 db_name1 [db_name2 ..]"; }

for arg in "$@"; do
  case "$arg" in
    -h|--help)
      do_help; exit 0
      ;;
    *)
      dbs=(${dbs[@]} "$arg")
    ;;
  esac
done

PSQL(){
  echo ">> loading $1"
  psql -d "$db" -f $1
}

for db in ${dbs[@]}; do
  createlang plpgsql "$db"

  # mandatory
  for sql in $sql_files; do
    PSQL $sql
  done

done
