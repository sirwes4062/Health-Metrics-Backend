import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service.js';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async register(
    fullName: string,
    email: string,
    password: string,
    role = 'practitioner',
    ip = 'unknown',
  ) {
    const normalizedEmail = email.trim().toLowerCase();
    const existingUser = await this.prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (existingUser) {
      throw new ConflictException('An account with this email already exists');
    }

    const user = await this.prisma.user.create({
      data: {
        fullName: fullName.trim(),
        email: normalizedEmail,
        password: await bcrypt.hash(password, 12),
        role,
      },
    });

    await this.prisma.authLog.create({
      data: {
        userEmail: normalizedEmail,
        userId: user.id,
        status: 'registered',
        ip,
      },
    });

    return this.toPublicUser(user);
  }

  async validateUser(email: string, pass: string, ip: string): Promise<any> {
    const normalizedEmail = email.trim().toLowerCase();
    const user = await this.prisma.user.findUnique({
      where: { email: normalizedEmail },
    });

    if (user && (await bcrypt.compare(pass, user.password))) {
      // Log successful attempt
      await this.prisma.authLog.create({
        data: {
          userEmail: normalizedEmail,
          userId: user.id,
          status: 'success',
          ip,
        },
      });

      return this.toPublicUser(user);
    }

    // Log failed attempt
    await this.prisma.authLog.create({
      data: { userEmail: normalizedEmail, status: 'failed', ip },
    });

    return null;
  }

  async login(user: any) {
    const payload = {
      sub: user.id,
      fullName: user.fullName,
      email: user.email,
      role: user.role,
    };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  private toPublicUser(user: {
    id: string;
    fullName: string;
    email: string;
    role: string;
    createdAt: Date;
  }) {
    return {
      id: user.id,
      fullName: user.fullName,
      email: user.email,
      role: user.role,
      createdAt: user.createdAt,
    };
  }
}
