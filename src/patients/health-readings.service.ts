import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service.js';

export type CreateHealthReadingInput = {
  weightKg?: number;
  heightCm?: number;
  bmi?: number;
  heartRate?: number;
  temperature?: number;
  spo2?: number;
};

@Injectable()
export class HealthReadingsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(patientId: string, input: CreateHealthReadingInput) {
    await this.ensurePatientExists(patientId);

    return this.prisma.healthReading.create({
      data: {
        patientId,
        weightKg: input.weightKg!,
        heightCm: input.heightCm!,
        bmi: input.bmi!,
        heartRate: input.heartRate!,
        temperature: input.temperature!,
        spo2: input.spo2!,
      },
    });
  }

  async findByPatient(patientId: string) {
    await this.ensurePatientExists(patientId);

    return this.prisma.healthReading.findMany({
      where: { patientId },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(readingId: string) {
    const reading = await this.prisma.healthReading.findUnique({
      where: { id: readingId },
    });

    if (!reading) {
      throw new NotFoundException('Health reading not found');
    }

    return reading;
  }

  private async ensurePatientExists(patientId: string) {
    const patient = await this.prisma.patient.findUnique({
      where: { id: patientId },
      select: { id: true },
    });

    if (!patient) {
      throw new NotFoundException('Patient not found');
    }
  }
}
