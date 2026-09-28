import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard.js';
import { HealthReadingsService } from './health-readings.service.js';
import type { CreateHealthReadingInput } from './health-readings.service.js';
import { PatientsService } from './patients.service.js';
import type { CreatePatientInput } from './patients.service.js';

const bloodGroups = new Set(['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']);

@Controller('patients')
@UseGuards(JwtAuthGuard)
export class PatientsController {
  constructor(
    private readonly patientsService: PatientsService,
    private readonly healthReadingsService: HealthReadingsService,
  ) {}

  @Post()
  create(@Body() body: CreatePatientInput) {
    const age = Number(body.age);
    const bloodGroup = body.bloodGroup?.trim().toUpperCase();

    if (
      !body.fullName?.trim() ||
      !body.email?.trim() ||
      !Number.isInteger(age) ||
      age < 0 ||
      age > 120 ||
      !body.gender?.trim() ||
      !bloodGroup ||
      !bloodGroups.has(bloodGroup) ||
      !body.phone?.trim()
    ) {
      throw new BadRequestException(
        'fullName, email, age, gender, bloodGroup, and phone are required',
      );
    }

    return this.patientsService.create({
      ...body,
      age,
      bloodGroup,
    });
  }

  @Get()
  findAll() {
    return this.patientsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.patientsService.findOne(id);
  }

  //Get All Readings for One Patient
  @Post(':patientId/health-readings')
  createHealthReading(
    @Param('patientId') patientId: string,
    @Body() body: CreateHealthReadingInput,
  ) {
    const values = [
      body.weightKg,
      body.heightCm,
      body.bmi,
      body.heartRate,
      body.temperature,
      body.spo2,
    ];

    if (
      values.some(
        (value) => typeof value !== 'number' || !Number.isFinite(value),
      ) ||
      body.weightKg! <= 0 ||
      body.heightCm! <= 0 ||
      body.bmi! <= 0 ||
      body.heartRate! <= 0 ||
      body.temperature! <= 0 ||
      body.spo2! < 0 ||
      body.spo2! > 100
    ) {
      throw new BadRequestException(
        'Valid weightKg, heightCm, bmi, heartRate, temperature, and spo2 values are required',
      );
    }

    return this.healthReadingsService.create(patientId, body);
  }

  @Get(':patientId/health-readings')
  findPatientHealthReadings(@Param('patientId') patientId: string) {
    return this.healthReadingsService.findByPatient(patientId);
  }

  @Get('health-readings/:readingId')
  findHealthReading(@Param('readingId') readingId: string) {
    return this.healthReadingsService.findOne(readingId);
  }
}
