import {
  Controller,
  Get,
  Post,
  Delete,
  Body,
  Req,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { HardwareSessionService } from './hardware-session.service.js';

@Controller('hardware-session')
export class HardwareSessionController {
  constructor(private readonly sessionService: HardwareSessionService) {}

  @Post('start')
  startSession(@Body('patientId') patientId: string, @Req() req: any) {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new HttpException(
        'Missing authorization token',
        HttpStatus.UNAUTHORIZED,
      );
    }

    const token = authHeader.split(' ')[1];
    this.sessionService.setSession(patientId, token);

    return { message: 'Hardware session activated', patientId };
  }

  @Get('active')
  getActiveSession() {
    const session = this.sessionService.getSession();
    if (!session) {
      throw new HttpException('No active session', HttpStatus.NOT_FOUND);
    }
    return session;
  }

  @Delete('clear')
  clearSession() {
    this.sessionService.clearSession();
    return { message: 'Hardware session cleared' };
  }
}
