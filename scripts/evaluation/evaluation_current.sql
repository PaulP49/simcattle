SELECT 
1 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location
  GROUP BY space_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
) AS MOST_VISITED_SPACE,
(
  SELECT SUM(s.chg_cnt)
  FROM
  (
    SELECT SUM(CASE WHEN t.prev_val <> t.space_id OR t.prev_val IS NULL THEN 1 END) as chg_cnt
    FROM
      (
        SELECT cattle_id, start_time, space_id, LAG(space_id) OVER(PARTITION BY cattle_id ORDER BY start_time) prev_val
        FROM location
      ) as t
    GROUP BY cattle_id
  ) as s
) AS TOTAL_SPACES_MOVED,
(
  SELECT ROUND(AVG(s.chg_cnt), 2)
  FROM
  (
    SELECT SUM(CASE WHEN t.prev_val <> t.space_id OR t.prev_val IS NULL THEN 1 END) as chg_cnt
    FROM
      (
        SELECT cattle_id, start_time, space_id, LAG(space_id) OVER(PARTITION BY cattle_id ORDER BY start_time) prev_val
        FROM location
      ) as t
    GROUP BY cattle_id
  ) as s
) AS AVG_SPACES_MOVED,
(
  SELECT ROUND(AVG(TOTAL_DISTANCE), 2)
  FROM
  (
    SELECT cattle_id, SUM(DISTANCE) AS TOTAL_DISTANCE
    FROM
    (
      SELECT t.*,
      (CASE WHEN t.cattle_id = t.prev_cattle_id THEN
        111.111 *
        DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t.lat)) *
        COS(RADIANS(t.prev_lat)) *
        COS(RADIANS(t.long - t.prev_long)) +
        SIN(RADIANS(t.lat)) *
        SIN(RADIANS(t.prev_lat)))))
      END) AS DISTANCE
      FROM
      (
        SELECT cattle_id, latitude as lat, longitude as 'long',
        LAG(latitude) OVER(PARTITION BY cattle_id ORDER BY start_time) prev_lat,
        LAG(longitude) OVER(PARTITION BY cattle_id ORDER BY start_time) prev_long,
        LAG(cattle_id) OVER(PARTITION BY cattle_id ORDER BY start_time) prev_cattle_id
        FROM location
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location
