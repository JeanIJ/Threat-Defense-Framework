# Threat Intelligence Brief
**Classification:** INTERNAL (LAB SIMULATION)  
**Analyst:** Jean Irakiza

---

## 1. Adversary Profile: APT-SYNTH-01
* **Aliases:** Synthetic Panda, LAB-APT-01  
* **Motivation:** Espionage and intellectual property theft  
* **Target Sector:** Technology and Defense Contractors  
* **Sophistication:** Medium-High  

## 2. MITRE ATT&CK Mapping

| Tactic | Technique ID | Technique Name | Procedure |
| :--- | :--- | :--- | :--- |
| Initial Access | T1566.001 | Spearphishing Attachment | Malicious PDF with embedded macros |
| Execution | T1059.003 | Windows Command Shell | Batch scripts for payload delivery |
| Persistence | T1547.001 | Registry Run Keys | Adds key `HKCU\Software\Microsoft\Windows\CurrentVersion\Run\UpdateSvc` |
| Privilege Escalation | T1055.012 | Process Hollowing | Injects into `svchost.exe` |
| Defense Evasion | T1027 | Obfuscated Files | Base64-encoded PowerShell commands |
| Credential Access | T1003.001 | LSASS Memory | Dump credentials via mimikatz variant |
| Discovery | T1083 | File and Directory Discovery | Enumerates `C:\Users\*\Documents` |
| Lateral Movement | T1021.002 | SMB/Windows Admin Shares | Copies payload to `ADMIN$` share |
| Exfiltration | T1041 | Exfiltration Over C2 | HTTPS beacon to `cdn-updates[.]lab-synth[.]net` |

## 3. Risk to Organization
* **Likelihood:** Medium (simulated targeting of tech sector)
* **Impact:** High (credential theft + IP exfiltration)
* **Risk Rating:** **HIGH**

## 4. Recommendations
1. Block identified IOCs at the perimeter firewall.
2. Hunt for T1059.003 (PowerShell execution) anomalies in EDR logs.
3. Enable strict macro blocking for Office documents globally.
4. Monitor `svchost.exe` for abnormal parent-child process relationships.