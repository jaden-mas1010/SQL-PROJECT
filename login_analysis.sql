


-- 1. Login attempts by country
SELECT event_id, country
FROM log_in_attempts;

-- 2. Login attempts outside working hours (08:00 - 18:00)
SELECT username, login_date, login_time
FROM log_in_attempts
WHERE login_time NOT BETWEEN '08:00:00' AND '18:00:00'
ORDER BY login_date, login_time;

-- 3. Count login attempts per country
SELECT country, COUNT(*) AS attempts
FROM log_in_attempts
GROUP BY country
ORDER BY attempts DESC;

-- 4. Users with multiple failed logins (>3)
SELECT username, COUNT(*) AS failed_attempts
FROM log_in_attempts
WHERE status = 'Failed'
GROUP BY username
HAVING failed_attempts > 3
ORDER BY failed_attempts DESC;

-- 5. Most active login day per user
SELECT username, login_date, COUNT(*) AS logins
FROM log_in_attempts
GROUP BY username, login_date
ORDER BY username, logins DESC;

-- 6. Join devices with login attempts (example)
SELECT m.employee_id, m.device_id, m.operating_system, l.username, l.login_date
FROM machines m
JOIN log_in_attempts l
    ON m.employee_id = l.employee_id
WHERE l.login_date >= '2023-01-01'
ORDER BY l.login_date DESC;

-- 7. Window functions: Rank users by total logins
SELECT username,
       login_date,
       COUNT(*) OVER (PARTITION BY username) AS total_logins
FROM log_in_attempts
ORDER BY total_logins DESC;

-- 8. Cumulative login attempts per day
SELECT login_date,
       SUM(COUNT(*)) OVER (ORDER BY login_date) AS cumulative_logins
FROM log_in_attempts
GROUP BY login_date
ORDER BY login_date;
