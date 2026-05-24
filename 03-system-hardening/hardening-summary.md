# System Hardening Summary
**Analyst:** Jean Irakiza
  **System:** Kali Lab Workstation (simulated enterprise endpoint) 

---

## 1. Privilege Audit Findings

### Before Hardening

| User | UID | Groups | Risk |
|------|-----|--------|------|
| root | 0 | root | Expected |
| admin | 1000 | sudo, adm, docker | **Overprivileged — docker group = root equiv** |
| backupsvc | 1001 | sudo | **Unnecessary sudo — service account** |
| testuser | 1002 | sudo, adm | **Test account with production privileges** |
| guest | 1003 | users | **Weak password: guest123** |

### After Hardening

| User | UID | Groups | Status |
|------|-----|-------|--------|
| root | 0 | root | Password rotation enforced |
| admin | 1000 | sudo, adm | **Removed from docker group** |
| backupsvc | 1001 | backup | **Removed sudo, created dedicated group** |
| testuser | 1002 | users | **Removed sudo and adm, disabled account** |
| guest | 1003 | — | **"Account deleted** |

---

## 2. Log Review — Unauthorized Access Attempts

```bash
# Simulated auth.log analysis
grep "Failed password" /var/log/auth.log | tail -20

May 22 03:15:22 lab-host sshd[1234]: Failed password for root from 192.168.255.10 port 54321 ssh2
May 22 03:15:25 lab-host sshd[1234]: Failed password for root from 192.168.255.10 port 54321 ssh2
May 22 03:15:28 lab-host sshd[1234]: Failed password for root from 192.168.255.10 port 54321 ssh2
May 22 04:02:11 lab-host sshd[5678]: Failed password for admin from 10.0.0.99 port 49200 ssh2
```

**Findings:**
- 47 failed root login attempts from `192.168.255.10` (C2 IP match)
- Brute force pattern: 3 attempts per IP, rotating through users
- `10.0.0.99` attempted lateral movement via compromised `admin` account

---

## 3. Misconfigurations Found


| Issue | Severity | Location |
|------|---------|----------|
| SSH root login enabled | Critical | `/etc/ssh/sshd_config` |
| Password auth enabled for SSH | High | `/etc/ssh/sshd_config` |
| Unnecessary service: telnet | Critical | `inetd.conf` |
| World-writable directory | Medium | `/var/tmp` (777) |
| SUID binary on custom script | High | `/usr/local/bin/backup.sh` |

---

## 4. Hardening Improvements Applied

### 4.1 SSH Hardening
- Disabled root login: `PermitRootLogin no`
- Disabled password auth: `PasswordAuthentication no`
- Enforced key-based auth only
- Changed SSH port to 2222 (non-standard, obscurity layer)

### 4.2 Service Reduction
- Stopped and disabled telnet: `systemctl stop inetd && systemctl disable inetd`
- Removed unnecessary packages: `telnet`, `ftp`, `rsh`
- Verified only required services: ssh, cron, auditd

### 4.3 Permission Fixes
- `chmod 755 /var/tmp`
- Removed SUID from backup script: `chmod u-s /usr/local/bin/backup.sh`
- Enforced umask 027 for all users

### 4.4 Account Hardening
- Enforced password complexity (min 14 chars, complexity rules)
- Set account lockout after 5 failed attempts
- Disabled inactive accounts after 30 days
- Implemented sudo timeout (5 minutes)

---

## 5. Verification

```bash
# Post-hardening checks
sudo ssh -T -o StrictHostKeyChecking=no -p 2222 admin@localhost "whoami"
# Result: Permission denied (publickey) — correct, password blocked

sudo grep "Failed password" /var/log/auth.log | wc -l
# Result: 0 new failures in 24h post-hardening

sudo systemctl list-units --type=service --state=running | wc -l
# Result: Reduced from 47 to 31 active services
```

## 6. Recommendations
1. Deploy centralized logging (SIEM) for real-time alerting
2. Implement EDR on all endpoints
3. Schedule quarterly privilege audits
4. Enable AppArmor/SELinux enforcing mode
5. Deploy automated vulnerability scanning (OpenVAS/Nessus)
