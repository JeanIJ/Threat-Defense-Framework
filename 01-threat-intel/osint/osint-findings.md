# OSINT Reconnaissance Report
**Target Domain:** `target-lab.local`  
**Analyst:** Jean Irakiza  

## 1. Infrastructure Discovery
Utilized `theHarvester` to enumerate external-facing assets for the simulated target environment. 

**Discovered Subdomains:**
* `vpn.target-lab.local`
* `mail.target-lab.local`
* `dev-portal.target-lab.local`

## 2. Infrastructure Links
Maltego analysis identified that the external IP addresses associated with `target-lab.local` share a hosting provider block with known synthetic malicious infrastructure (`lab-synth.net`).

## 3. Threat Surface Assessment
The presence of an exposed developer portal (`dev-portal`) and VPN gateway provides a high-value attack surface for initial access vectors, aligning with APT-SYNTH-01's known TTPs.