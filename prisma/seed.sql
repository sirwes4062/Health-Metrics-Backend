INSERT INTO "Patient" ("id", "fullName", "email", "age", "gender", "bloodGroup", "phone", "createdAt", "updatedAt")
VALUES
  ('10000000-0000-4000-8000-000000000001', 'Avery Morgan', 'avery.morgan@example.test', 29, 'Female', 'O+', '+1 202 555 0101', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000002', 'Jordan Williams', 'jordan.williams@example.test', 41, 'Male', 'A-', '+1 202 555 0102', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000003', 'Taylor Bennett', 'taylor.bennett@example.test', 36, 'Non-binary', 'B+', '+1 202 555 0103', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000004', 'Morgan Ellis', 'morgan.ellis@example.test', 52, 'Female', 'AB+', '+1 202 555 0104', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000005', 'Casey Rivera', 'casey.rivera@example.test', 23, 'Male', 'O-', '+1 202 555 0105', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000006', 'Riley Thompson', 'riley.thompson@example.test', 47, 'Female', 'B-', '+1 202 555 0106', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000007', 'Cameron Brooks', 'cameron.brooks@example.test', 61, 'Male', 'A+', '+1 202 555 0107', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000008', 'Jamie Patel', 'jamie.patel@example.test', 30, 'Female', 'AB-', '+1 202 555 0108', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000009', 'Drew Carter', 'drew.carter@example.test', 38, 'Male', 'O+', '+1 202 555 0109', NOW(), NOW()),
  ('10000000-0000-4000-8000-000000000010', 'Alexis Foster', 'alexis.foster@example.test', 55, 'Female', 'A-', '+1 202 555 0110', NOW(), NOW())
ON CONFLICT ("email") DO NOTHING;

INSERT INTO "HealthReading" ("id", "patientId", "weightKg", "heightCm", "bmi", "heartRate", "temperature", "spo2", "createdAt")
VALUES
  ('20000000-0000-4000-8000-000000000001', '10000000-0000-4000-8000-000000000001', 68.4, 172.0, 23.1, 72, 36.6, 98, NOW()),
  ('20000000-0000-4000-8000-000000000002', '10000000-0000-4000-8000-000000000002', 84.7, 181.0, 25.9, 79, 37.0, 97, NOW()),
  ('20000000-0000-4000-8000-000000000003', '10000000-0000-4000-8000-000000000001', 68.1, 172.0, 23.0, 70, 36.5, 99, NOW()),
  ('20000000-0000-4000-8000-000000000004', '10000000-0000-4000-8000-000000000001', 68.7, 172.0, 23.2, 73, 36.7, 98, NOW()),
  ('20000000-0000-4000-8000-000000000005', '10000000-0000-4000-8000-000000000001', 69.0, 172.0, 23.3, 75, 36.6, 97, NOW()),
  ('20000000-0000-4000-8000-000000000006', '10000000-0000-4000-8000-000000000001', 68.6, 172.0, 23.2, 71, 36.8, 98, NOW()),
  ('20000000-0000-4000-8000-000000000007', '10000000-0000-4000-8000-000000000001', 68.3, 172.0, 23.1, 72, 36.6, 99, NOW()),
  ('20000000-0000-4000-8000-000000000008', '10000000-0000-4000-8000-000000000002', 84.4, 181.0, 25.8, 78, 36.9, 98, NOW()),
  ('20000000-0000-4000-8000-000000000009', '10000000-0000-4000-8000-000000000002', 84.9, 181.0, 25.9, 80, 37.1, 97, NOW()),
  ('20000000-0000-4000-8000-000000000010', '10000000-0000-4000-8000-000000000002', 85.1, 181.0, 26.0, 82, 37.0, 96, NOW()),
  ('20000000-0000-4000-8000-000000000011', '10000000-0000-4000-8000-000000000002', 84.6, 181.0, 25.8, 77, 36.8, 98, NOW()),
  ('20000000-0000-4000-8000-000000000012', '10000000-0000-4000-8000-000000000002', 84.2, 181.0, 25.7, 79, 36.9, 99, NOW())
ON CONFLICT ("id") DO NOTHING;

INSERT INTO "HealthReading" ("id", "patientId", "weightKg", "heightCm", "bmi", "heartRate", "temperature", "spo2", "createdAt")
SELECT seed."id", patient."id", seed."weightKg", seed."heightCm", seed."bmi", seed."heartRate", seed."temperature", seed."spo2", seed."createdAt"
FROM (VALUES
  ('20000000-0000-4000-8000-000000000013', 'taylor.bennett@example.test', 73.8, 168.0, 26.1, 74, 36.7, 98, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000014', 'taylor.bennett@example.test', 73.4, 168.0, 26.0, 72, 36.6, 99, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000015', 'taylor.bennett@example.test', 73.0, 168.0, 25.9, 73, 36.8, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000016', 'morgan.ellis@example.test', 72.4, 165.0, 26.6, 78, 36.8, 97, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000017', 'morgan.ellis@example.test', 71.9, 165.0, 26.4, 76, 36.7, 98, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000018', 'morgan.ellis@example.test', 71.6, 165.0, 26.3, 75, 36.6, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000019', 'casey.rivera@example.test', 76.2, 178.0, 24.1, 68, 36.5, 99, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000020', 'casey.rivera@example.test', 76.5, 178.0, 24.1, 70, 36.6, 98, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000021', 'casey.rivera@example.test', 76.0, 178.0, 24.0, 69, 36.5, 99, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000022', 'riley.thompson@example.test', 64.8, 160.0, 25.3, 76, 36.7, 98, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000023', 'riley.thompson@example.test', 65.1, 160.0, 25.4, 78, 36.8, 97, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000024', 'riley.thompson@example.test', 64.7, 160.0, 25.3, 75, 36.6, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000025', 'cameron.brooks@example.test', 82.1, 174.0, 27.1, 80, 36.8, 97, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000026', 'cameron.brooks@example.test', 81.8, 174.0, 27.0, 78, 36.7, 98, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000027', 'cameron.brooks@example.test', 81.6, 174.0, 26.9, 77, 36.6, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000028', 'jamie.patel@example.test', 59.4, 169.0, 20.8, 72, 36.6, 99, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000029', 'jamie.patel@example.test', 59.1, 169.0, 20.7, 70, 36.5, 99, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000030', 'jamie.patel@example.test', 59.3, 169.0, 20.8, 71, 36.6, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000031', 'drew.carter@example.test', 88.1, 182.0, 26.6, 77, 36.7, 98, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000032', 'drew.carter@example.test', 87.7, 182.0, 26.5, 75, 36.6, 99, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000033', 'drew.carter@example.test', 87.4, 182.0, 26.4, 74, 36.7, 98, NOW() - INTERVAL '30 days'),
  ('20000000-0000-4000-8000-000000000034', 'alexis.foster@example.test', 70.2, 163.0, 26.4, 76, 36.8, 97, NOW() - INTERVAL '90 days'),
  ('20000000-0000-4000-8000-000000000035', 'alexis.foster@example.test', 69.9, 163.0, 26.3, 74, 36.6, 98, NOW() - INTERVAL '60 days'),
  ('20000000-0000-4000-8000-000000000036', 'alexis.foster@example.test', 69.5, 163.0, 26.1, 73, 36.5, 99, NOW() - INTERVAL '30 days')
) AS seed("id", "email", "weightKg", "heightCm", "bmi", "heartRate", "temperature", "spo2", "createdAt")
JOIN "Patient" patient ON patient."email" = seed."email"
ON CONFLICT ("id") DO NOTHING;

WITH patients_without_readings AS (
  SELECT
    patient."id",
    155 + get_byte(decode(md5(patient."id"), 'hex'), 0) % 35 AS "heightCm",
    50.0 + get_byte(decode(md5(patient."id"), 'hex'), 1) % 45 AS "baseWeightKg",
    65 + get_byte(decode(md5(patient."id"), 'hex'), 2) % 25 AS "baseHeartRate",
    96 + get_byte(decode(md5(patient."id"), 'hex'), 3) % 4 AS "spo2",
    36.4 + (get_byte(decode(md5(patient."id"), 'hex'), 4) % 7) / 10.0 AS "temperature"
  FROM "Patient" patient
  WHERE NOT EXISTS (
    SELECT 1
    FROM "HealthReading" reading
    WHERE reading."patientId" = patient."id"
  )
), generated_readings AS (
  SELECT
    patients."id" AS "patientId",
    visit,
    md5(patients."id" || '-seed-reading-' || visit)::uuid AS "readingId",
    patients."heightCm"::double precision AS "heightCm",
    patients."baseWeightKg" + (visit - 2) * 0.2 AS "weightKg",
    patients."baseHeartRate" + visit - 2 AS "heartRate",
    patients."temperature",
    patients."spo2"
  FROM patients_without_readings patients
  CROSS JOIN generate_series(1, 3) AS visit
)
INSERT INTO "HealthReading" ("id", "patientId", "weightKg", "heightCm", "bmi", "heartRate", "temperature", "spo2", "createdAt")
SELECT
  readings."readingId",
  readings."patientId",
  readings."weightKg",
  readings."heightCm",
  ROUND((readings."weightKg" / POWER(readings."heightCm" / 100.0, 2))::numeric, 1)::double precision,
  readings."heartRate",
  readings."temperature",
  readings."spo2",
  NOW() - (4 - readings.visit) * INTERVAL '30 days'
FROM generated_readings readings
ON CONFLICT ("id") DO NOTHING;
