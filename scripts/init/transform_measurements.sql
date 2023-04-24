INSERT INTO simcattle.learning_measurement (`wifi_ap`, `cnx_time`, `client_id`)
  SELECT SUBSTRING_INDEX(`beacon`, '-', -1), `time`, `device`
  FROM simcattle.measurement;
