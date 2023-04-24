SELECT 
1 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT device) as DISTINCT_ENTITIES,
COUNT(DISTINCT beacon) as COVERED_SPACES,
AVG(latitude) as AVG_LAT,
AVG(longitude) as AVG_LONG,
(
  SELECT beacon
  FROM connection
  WHERE DATE(time) = '2022-04-26'
  GROUP BY beacon
  ORDER BY COUNT(*) DESC
  LIMIT 1
) AS MOST_VISITED_SPACE,
(
  SELECT SUM(s.chg_cnt)
  FROM
  (
    SELECT SUM(CASE WHEN t.prev_val <> t.beacon OR t.prev_val IS NULL THEN 1 END) as chg_cnt
    FROM
      (
        SELECT device, time, beacon, LAG(beacon) OVER(PARTITION BY device ORDER BY time) prev_val
        FROM connection
        WHERE DATE(time) = '2022-04-26'
      ) as t
    GROUP BY device
  ) as s
) AS TOTAL_SPACES_MOVED,
(
  SELECT ROUND(AVG(s.chg_cnt), 2)
  FROM
  (
    SELECT SUM(CASE WHEN t.prev_val <> t.beacon OR t.prev_val IS NULL THEN 1 END) as chg_cnt
    FROM
      (
        SELECT device, time, beacon, LAG(beacon) OVER(PARTITION BY device ORDER BY time) prev_val
        FROM connection
        WHERE DATE(time) = '2022-04-26'
      ) as t
    GROUP BY device
  ) as s
) AS AVG_SPACES_MOVED,
(
  SELECT ROUND(AVG(TOTAL_DISTANCE), 2)
  FROM
  (
    SELECT device, SUM(DISTANCE) AS TOTAL_DISTANCE
    FROM
    (
      SELECT t.*,
      (CASE WHEN t.device = t.prev_device THEN
        111.111 *
        DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t.lat)) *
        COS(RADIANS(t.prev_lat)) *
        COS(RADIANS(t.long - t.prev_long)) +
        SIN(RADIANS(t.lat)) *
        SIN(RADIANS(t.prev_lat)))))
      END) AS DISTANCE
      FROM
      (
        SELECT device, latitude as lat, longitude as 'long',
        LAG(latitude) OVER(PARTITION BY device ORDER BY time) prev_lat,
        LAG(longitude) OVER(PARTITION BY device ORDER BY time) prev_long,
        LAG(device) OVER(PARTITION BY device ORDER BY time) prev_device
        FROM connection
        WHERE DATE(time) = '2022-04-26'
      ) as t
    ) as s
    GROUP BY device
  ) as v
) AS AVG_MOVED_DISTANCE_IN_KM
FROM connection
WHERE DATE(time) = '2022-04-26'
