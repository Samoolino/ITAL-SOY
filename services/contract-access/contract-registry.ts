export interface ContractRecord {
  contractId: string;
  sourceRepository: 'VITAL-SOY' | 'ITAL-SOY';
  sourceCommit: string;
  artifactHash?: string;
  abiHash?: string;
  network: string;
  address?: string;
  version: string;
  status: 'DEFINED' | 'DEPLOYED' | 'VERIFIED' | 'ACTIVE' | 'DEPRECATED';
}

export interface ContractAccessRequest {
  contractId: string;
  functionName: string;
  executionId?: string;
  idempotencyKey: string;
}

export interface ContractAccessDecision {
  allowed: boolean;
  reason: string;
  contract?: ContractRecord;
}

export class ContractRegistry {
  constructor(private readonly records: ContractRecord[]) {}

  resolve(contractId: string): ContractRecord | undefined {
    return this.records.find((r) => r.contractId === contractId && r.status !== 'DEPRECATED');
  }
}
