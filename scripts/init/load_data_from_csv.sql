-- 103_(W10T_A7H_2)
LOAD DATA INFILE '/data/103_(W10T_A7H_2).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "103_(W10T_A7H_2)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 125_(W10T_A7H_10)
LOAD DATA INFILE '/data/125_(W10T_A7H_10).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "125_(W10T_A7H_10)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 130_(W10T_A7H_1)
LOAD DATA INFILE '/data/130_(W10T_A7H_1).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "130_(W10T_A7H_1)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 142_(W10T_A7H_3)
LOAD DATA INFILE '/data/142_(W10T_A7H_3).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "142_(W10T_A7H_3)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 807_(W10T_A7H_5)
LOAD DATA INFILE '/data/807_(W10T_A7H_5).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "807_(W10T_A7H_5)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 838_(W10T_A7H_9)
LOAD DATA INFILE '/data/838_(W10T_A7H_9).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "838_(W10T_A7H_9)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 906_(W10T_A7H_8)
LOAD DATA INFILE '/data/906_(W10T_A7H_8).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "906_(W10T_A7H_8)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;

-- 930_(W10T_A7H_7)
LOAD DATA INFILE '/data/930_(W10T_A7H_7).csv'
INTO TABLE simcattle.measurement
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@valid, @time, @geofences, @latitude, @longitude, @altitude, @beacon, @major, @minor, @uuid, @speed, @attributes)
SET `valid` = @valid="TRUE",
    `device` = "930_(W10T_A7H_7)",
    `time` = @time,
    `geofences` = @geofences,
    `latitude` = @latitude,
    `longitude` = @longitude,
    `altitude` = @altitude,
    `beacon` = @beacon,
    `major` = @major,
    `minor` = @minor,
    `uuid` = @uuid,
    `speed` = @speed,
    `attributes` = @attributes;
