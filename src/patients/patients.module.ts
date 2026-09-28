import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module.js';
import { PatientsController } from './patients.controller.js';
import { PatientsService } from './patients.service.js';
import { HealthReadingsService } from './health-readings.service.js';

@Module({
  imports: [AuthModule],
  controllers: [PatientsController],
  providers: [PatientsService, HealthReadingsService],
})
export class PatientsModule {}
