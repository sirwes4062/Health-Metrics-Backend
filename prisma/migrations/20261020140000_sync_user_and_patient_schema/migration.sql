-- Add practitioner names while preserving existing users.
ALTER TABLE "User"
ADD COLUMN "fullName" TEXT NOT NULL DEFAULT 'Unknown Practitioner';

-- Add patient and health-reading tables defined in the Prisma schema.
CREATE TABLE "Patient" (
    "id" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,
    "bloodGroup" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Patient_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "HealthReading" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "weightKg" DOUBLE PRECISION NOT NULL,
    "heightCm" DOUBLE PRECISION NOT NULL,
    "bmi" DOUBLE PRECISION NOT NULL,
    "heartRate" DOUBLE PRECISION NOT NULL,
    "temperature" DOUBLE PRECISION NOT NULL,
    "spo2" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HealthReading_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "Patient_email_key" ON "Patient"("email");

ALTER TABLE "HealthReading"
ADD CONSTRAINT "HealthReading_patientId_fkey"
FOREIGN KEY ("patientId") REFERENCES "Patient"("id")
ON DELETE CASCADE ON UPDATE CASCADE;
