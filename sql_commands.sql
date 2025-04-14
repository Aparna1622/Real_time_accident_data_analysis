create database real_time_accident_data;

CREATE SCHEMA real_time_accident_data;

SHOW CREATE TABLE real_time_accident_data.accident_data;

ALTER TABLE accident_data
ADD CONSTRAINT collision_id_unique UNIQUE (collision_id);

ALTER TABLE accident_data
MODIFY crash_date DATE NOT NULL,
MODIFY crash_time TIME NOT NULL;

CREATE INDEX idx_borough ON accident_data(borough);
CREATE INDEX idx_latitude ON accident_data(latitude);
CREATE INDEX idx_longitude ON accident_data(longitude);

select * from real_time_accident_data.accident_data;

#Exploratory data analysis

#1. Daily Accident Summary

CREATE TABLE real_time_accident_data.daily_accident_summary AS
SELECT 
    DATE(crash_date) AS accident_date,
    COUNT(*) AS total_accidents,
    SUM(CAST(number_of_persons_injured AS UNSIGNED)) AS total_injuries
FROM real_time_accident_data.accident_data
GROUP BY DATE(crash_date);

SELECT * FROM real_time_accident_data.daily_accident_summary;

#2. Top Streets with Most Accidents

CREATE TABLE real_time_accident_data.top_dangerous_streets AS
SELECT 
    on_street_name,
    COUNT(*) AS accident_count,
    SUM(CAST(number_of_persons_injured AS UNSIGNED)) AS total_injuries
FROM real_time_accident_data.accident_data
WHERE on_street_name != 'UNKNOWN'
GROUP BY on_street_name
ORDER BY accident_count DESC
LIMIT 20;

SELECT * FROM real_time_accident_data.top_dangerous_streets;

#3. real_time_accident_data.top_dangerous_streets
CREATE TABLE real_time_accident_data.victim_type_summary AS
SELECT
    SUM(CAST(number_of_pedestrians_injured AS UNSIGNED)) AS pedestrians_injured,
    SUM(CAST(number_of_cyclist_injured AS UNSIGNED)) AS cyclists_injured,
    SUM(CAST(number_of_motorist_injured AS UNSIGNED)) AS motorists_injured,
    SUM(CAST(number_of_pedestrians_killed AS UNSIGNED)) AS pedestrians_killed,
    SUM(CAST(number_of_cyclist_killed AS UNSIGNED)) AS cyclists_killed,
    SUM(CAST(number_of_motorist_killed AS UNSIGNED)) AS motorists_killed
FROM real_time_accident_data.accident_data;

SELECT * FROM real_time_accident_data.victim_type_summary;

#4.Hourly Accident Distribution
CREATE TABLE real_time_accident_data.hourly_accident_distribution AS
SELECT 
    HOUR(STR_TO_DATE(crash_time, '%H:%i')) AS crash_hour,
    COUNT(*) AS accident_count
FROM real_time_accident_data.accident_data
GROUP BY crash_hour
ORDER BY crash_hour;

SELECT * FROM real_time_accident_data.hourly_accident_distribution;

#5. Borough + Street Hotspot Table
CREATE TABLE real_time_accident_data.borough_street_hotspots AS
SELECT 
    borough,
    on_street_name,
    COUNT(*) AS total_accidents,
    SUM(CAST(number_of_persons_injured AS UNSIGNED)) AS total_injuries
FROM real_time_accident_data.accident_data
WHERE on_street_name != 'UNKNOWN' AND borough != 'UNKNOWN'
GROUP BY borough, on_street_name
ORDER BY total_injuries DESC
LIMIT 30;

SELECT * FROM real_time_accident_data.borough_street_hotspots;

#6.Vehicle Type Involvement Summary
CREATE TABLE real_time_accident_data.vehicle_type_summary AS
SELECT 
    vehicle_type_code1 AS vehicle_type,
    COUNT(*) AS accident_count
FROM real_time_accident_data.accident_data
WHERE vehicle_type_code1 != 'UNKNOWN'
GROUP BY vehicle_type
ORDER BY accident_count DESC
LIMIT 15;

SELECT * FROM real_time_accident_data.vehicle_type_summary;

#7.View: vw_victim_severity_summary
CREATE OR REPLACE VIEW real_time_accident_data.vw_victim_severity_summary AS
SELECT
    borough,
    SUM(CAST(number_of_pedestrians_injured AS UNSIGNED)) AS pedestrians_injured,
    SUM(CAST(number_of_pedestrians_killed AS UNSIGNED)) AS pedestrians_killed,
    SUM(CAST(number_of_cyclist_injured AS UNSIGNED)) AS cyclists_injured,
    SUM(CAST(number_of_cyclist_killed AS UNSIGNED)) AS cyclists_killed,
    SUM(CAST(number_of_motorist_injured AS UNSIGNED)) AS motorists_injured,
    SUM(CAST(number_of_motorist_killed AS UNSIGNED)) AS motorists_killed
FROM real_time_accident_data.accident_data
GROUP BY borough;

SELECT * FROM real_time_accident_data.vw_victim_severity_summary;

#8.View: vw_top_10_streets_by_injuries

CREATE OR REPLACE VIEW real_time_accident_data.vw_top_10_streets_by_injuries AS
SELECT 
    on_street_name,
    COUNT(*) AS accident_count,
    SUM(CAST(number_of_persons_injured AS UNSIGNED)) AS total_injuries
FROM real_time_accident_data.accident_data
WHERE on_street_name IS NOT NULL AND on_street_name != ''
GROUP BY on_street_name
ORDER BY total_injuries DESC
LIMIT 10;

SELECT * FROM real_time_accident_data.vw_top_10_streets_by_injuries;











