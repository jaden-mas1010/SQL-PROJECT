
-- 1. Devices not updated in last 6 months
SELECT device_id, operating_system, OS_patch_date, employee_id
FROM machines
WHERE OS_patch_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY OS_patch_date ASC;

-- 2. Count of devices per OS
SELECT operating_system, COUNT(*) AS device_count
FROM machines
GROUP BY operating_system
ORDER BY device_count DESC;

-- 3. Top 3 employees with most devices
SELECT employee_id, COUNT(*) AS num_devices
FROM machines
GROUP BY employee_id
ORDER BY num_devices DESC
LIMIT 3;
