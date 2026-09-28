import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthService } from './auth.service.js';
import { JwtAuthGuard } from './jwt-auth.guard.js';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  register(
    @Body() body: { fullName?: string; email?: string; password?: string },
    @Req() request: { ip?: string },
  ) {
    if (
      !body.fullName?.trim() ||
      !body.email?.trim() ||
      !body.password ||
      body.password.length < 8
    ) {
      throw new BadRequestException(
        'Full name, email, and a password of at least 8 characters are required',
      );
    }

    return this.authService.register(
      body.fullName,
      body.email,
      body.password,
      'practitioner',
      request.ip,
    );
  }

  @UseGuards(AuthGuard('local'))
  @Post('login')
  login(@Req() request: { user: unknown }) {
    return this.authService.login(request.user);
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  me(@Req() request: { user: unknown }) {
    return request.user;
  }
}
