#!/bin/bash
CONFIG_FROM=/opt/o2server/config_default
CONFIG_TO=/opt/o2server/config
for f in $(ls $CONFIG_FROM); do
  if [ -f $CONFIG_FROM/$f ]; then
    if ! [ -e $CONFIG_TO/$f ]; then
      cp $CONFIG_FROM/$f $CONFIG_TO/$f
      if [ $f = "externalDataSources.json" ]; then
        sed -i 's#DB_HOST#'"$DB_HOST"'#g' $CONFIG_TO/$f
        sed -i 's#DB_PORT#'"$DB_PORT"'#g' $CONFIG_TO/$f
        sed -i 's#DB_USER#'"$DB_USER"'#g' $CONFIG_TO/$f
        sed -i 's#DB_PASSWORD#'"$DB_PASSWORD"'#g' $CONFIG_TO/$f
      fi
    fi
  fi
done
if [ -n "$DB_HOST" ] && [ -n "$DB_PORT" ]; then
  TIMEOUT=30
  STATUS="waiting"
  echo "Waiting for database at $DB_HOST:$DB_PORT"
  for i in `seq $TIMEOUT`; do
    (echo > /dev/tcp/$DB_HOST/$DB_PORT) >/dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]; then
      STATUS="done"
      break
    fi
    sleep 1
  done
  if [ $STATUS = "done" ]; then
    echo "Database is available after $i seconds"
  else
    echo "Database is not available after $TIMEOUT seconds"
    exit 1
  fi
fi
/opt/o2server/start_linux.sh
