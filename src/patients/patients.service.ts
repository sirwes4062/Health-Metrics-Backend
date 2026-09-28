import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service.js';

export type CreatePatientInput = {
  fullName?: string;
  email?: string;
  age?: number;
  gender?: string;
  bloodGroup?: string;
  phone?: string;
};

@Injectable()
export class PatientsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(input: CreatePatientInput) {
    const email = input.email!.trim().toLowerCase();

    try {
      return await this.prisma.patient.create({
        data: {
          fullName: input.fullName!.trim(),
          email,
          age: input.age!,
          gender: input.gender!.trim(),
          bloodGroup: input.bloodGroup!.trim().toUpperCase(),
          phone: input.phone!.trim(),
        },
      });
    } catch (error) {
      if (this.isUniqueConstraintError(error)) {
        throw new ConflictException('A patient with this email already exists');
      }
      throw error;
    }
  }

  async findAll() {
    return this.prisma.patient.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        healthReadings: {
          orderBy: { createdAt: 'desc' },
        },
      },
    });
  }

  async findOne(id: string) {
    const patient = await this.prisma.patient.findUnique({
      where: { id },
      include: {
        healthReadings: {
          orderBy: { createdAt: 'desc' },
        },
      },
    });
    if (!patient) {
      throw new NotFoundException('Patient not found');
    }
    return patient;
  }

  private isUniqueConstraintError(error: unknown) {
    return (
      typeof error === 'object' &&
      error !== null &&
      'code' in error &&
      error.code === 'P2002'
    );
  }
}
