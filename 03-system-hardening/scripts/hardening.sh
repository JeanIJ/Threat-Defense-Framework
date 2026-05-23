#!/bin/bash
# System Hardening Script
# Target: Kali Lab Workstation
# WARNING: Review before running in production

echo "[*] Starting system hardening..."

# 1. Update system
echo "[*] Updating packages..."
apt-get update && apt-get upgrade -y

# 2. SSH Hardening
echo "[*] Hardening SSH..."
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
systemctl restart sshd

# 3. Remove unnecessary services
echo "[*] Removing legacy services..."
apt-get remove -y telnet ftp rsh-client rsh-redone-client
systemctl stop inetd 2>/dev/null || true
systemctl disable inetd 2>/dev/null || true

# 4. Fix permissions
echo "[*] Fixing dangerous permissions..."
chmod 755 /var/tmp
find / -perm -4000 -type f 2>/dev/null | while read file; do
    if [[ "$file" == "/usr/local/bin/backup.sh" ]]; then
        chmod u-s "$file"
        echo "[*] Removed SUID from $file"
    fi
done

# 5. Account hardening
echo "[*] Hardening accounts..."
usermod -G admin,adm,sudo admin        	# Remove docker
usermod -G backup backupsvc             	# Remove sudo
usermod -s /usr/sbin/nologin backupsvc 	# Disable shell
usermod -L testuser                     	# Lock test account
userdel -r guest 2>/dev/null || true   	# Remove guest

# 6. Password policy
echo "[*] Enforcing password policy..."
apt-get install -y libpam-pwquality
sed -i 's/# minlen = 8/minlen = 14/' /etc/security/pwquality.conf
sed -i 's/# minclass = 0/minclass = 3/' /etc/security/pwquality.conf

# 7. Enable auditd
echo "[*] Enabling audit framework..."
systemctl enable auditd
systemctl start auditd
auditctl -w /etc/passwd -p wa -k identity_changes
nuditctl -w /etc/shadow -p wa -k identity_changes

# 8. Firewall
echo "[*] Configuring firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow 2222/tcp
ufw enable

echo "[*] Hardening complete. Review /var/log/hardening.log"
