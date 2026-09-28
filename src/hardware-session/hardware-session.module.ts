import { Module } from '@nestjs/common';
import { HardwareSessionController } from './hardware-session.controller.js';
import { HardwareSessionService } from './hardware-session.service.js';

@Module({
  controllers: [HardwareSessionController],
  providers: [HardwareSessionService],
  exports: [HardwareSessionService],
})
export class HardwareSessionModule {}
