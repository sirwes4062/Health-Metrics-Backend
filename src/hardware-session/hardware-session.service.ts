import { Injectable } from '@nestjs/common';

export interface ActiveSession {
  patientId: string;
  token: string;
}

@Injectable()
export class HardwareSessionService {
  private activeSession: ActiveSession | null = null;

  setSession(patientId: string, token: string): void {
    this.activeSession = { patientId, token };
  }

  getSession(): ActiveSession | null {
    return this.activeSession;
  }

  clearSession(): void {
    this.activeSession = null;
  }
}