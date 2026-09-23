export type AppRole =
  | 'GOVERNANCE_ADMIN' | 'QA_LEAD' | 'COMPLIANCE_OFFICER' | 'RISK_OFFICER'
  | 'ECONOMIC_ANALYST' | 'TRACEABILITY_OFFICER' | 'AUTHORIZER'
  | 'STRATEGY_OPERATOR' | 'RESERVATION_OPERATOR' | 'EXECUTOR'
  | 'AUDITOR' | 'DEPLOYMENT_ADMIN';

export interface AccessContext {
  userId: string;
  organizationId: string;
  roles: AppRole[];
  dataClasses: string[];
  wallet?: string;
}

export interface ContractPermission {
  contractId: string;
  functionName: string;
  requiredRoles: AppRole[];
  requiredDataClasses: string[];
  requiresSigner: boolean;
}

export function canInvoke(ctx: AccessContext, permission: ContractPermission): boolean {
  const roleOk = permission.requiredRoles.length === 0 || permission.requiredRoles.some((r) => ctx.roles.includes(r));
  const dataOk = permission.requiredDataClasses.every((d) => ctx.dataClasses.includes(d));
  const signerOk = !permission.requiresSigner || Boolean(ctx.wallet);
  return roleOk && dataOk && signerOk;
}
