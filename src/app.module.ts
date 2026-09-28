import { Module } from '@nestjs/common';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { AuthModule } from './auth/auth.module.js';
import { PrismaModule } from './prisma/prisma.module.js';
import { PatientsModule } from './patients/patients.module.js';
import { HardwareSessionModule } from './hardware-session/hardware-session.module.js';

@Module({
  imports: [AuthModule, PrismaModule, PatientsModule, HardwareSessionModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
