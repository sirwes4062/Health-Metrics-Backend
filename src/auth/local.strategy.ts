import { Strategy } from 'passport-local';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthService } from './auth.service.js';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private authService: AuthService) {
    super({ usernameField: 'email', passReqToCallback: true });
  }

  async validate(req: any, email: string, pass: string): Promise<any> {
    const ip = req.ip || 'unknown';
    const user = await this.authService.validateUser(email, pass, ip);
    if (!user) {
      throw new UnauthorizedException('Invalid clinical credentials');
    }
    return user;
  }
}
