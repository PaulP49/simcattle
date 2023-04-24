SELECT 
1 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_1
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
        FROM location_1
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
        FROM location_1
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
        FROM location_1
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_1

UNION

SELECT 
2 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_2
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
        FROM location_2
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
        FROM location_2
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
        FROM location_2
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_2

UNION

SELECT 
3 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_3
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
        FROM location_3
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
        FROM location_3
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
        FROM location_3
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_3

UNION

SELECT 
4 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_4
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
        FROM location_4
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
        FROM location_4
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
        FROM location_4
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_4

UNION

SELECT 
5 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_5
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
        FROM location_5
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
        FROM location_5
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
        FROM location_5
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_5

UNION

SELECT 
6 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_6
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
        FROM location_6
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
        FROM location_6
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
        FROM location_6
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_6

UNION

SELECT 
7 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_7
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
        FROM location_7
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
        FROM location_7
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
        FROM location_7
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_7

UNION

SELECT 
8 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_8
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
        FROM location_8
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
        FROM location_8
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
        FROM location_8
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_8

UNION

SELECT 
9 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_9
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
        FROM location_9
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
        FROM location_9
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
        FROM location_9
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_9

UNION

SELECT 
10 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_10
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
        FROM location_10
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
        FROM location_10
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
        FROM location_10
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_10

UNION

SELECT 
11 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_11
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
        FROM location_11
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
        FROM location_11
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
        FROM location_11
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_11

UNION

SELECT 
12 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_12
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
        FROM location_12
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
        FROM location_12
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
        FROM location_12
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_12

UNION

SELECT 
13 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_13
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
        FROM location_13
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
        FROM location_13
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
        FROM location_13
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_13

UNION

SELECT 
14 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_14
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
        FROM location_14
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
        FROM location_14
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
        FROM location_14
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_14

UNION

SELECT 
15 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_15
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
        FROM location_15
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
        FROM location_15
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
        FROM location_15
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_15

UNION

SELECT 
16 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_16
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
        FROM location_16
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
        FROM location_16
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
        FROM location_16
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_16

UNION

SELECT 
17 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_17
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
        FROM location_17
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
        FROM location_17
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
        FROM location_17
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_17

UNION

SELECT 
18 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_18
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
        FROM location_18
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
        FROM location_18
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
        FROM location_18
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_18

UNION

SELECT 
18 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_20
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
        FROM location_20
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
        FROM location_20
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
        FROM location_20
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_20

UNION

SELECT 
18 as TEST_CASE,
COUNT(*) as TOTAL_LOCATIONS,
COUNT(DISTINCT cattle_id) as DISTINCT_ENTITIES,
COUNT(DISTINCT space_id) as COVERED_SPACES,
(
  SELECT space_id
  FROM location_21
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
        FROM location_21
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
        FROM location_21
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
        FROM location_21
      ) as t
    ) as s
    GROUP BY cattle_id
  ) as v
) AS AVG_DISTANCE_MOVED_IN_KM
FROM location_21
