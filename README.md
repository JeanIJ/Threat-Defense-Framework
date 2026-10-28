# Threat Defense Framework

Notes from a lab security assessment, kept in the order the work was done. The threat group, indicators, phishing mail, and malware notes are synthetic. The packet capture and account listings were taken on the Kali VM used for the lab. None of this is data from a real engagement.

## Structure

- `01-threat-intel/` — adversary profile, OSINT notes, and indicators
- `02-attack-malware-analysis/` — phishing email, payload notes, and sandbox behavior
- `03-system-hardening/` — privilege audit and a hardening script for the lab host
- `04-network-monitoring/` — packet capture, Snort rules, and a defense report

The reports are markdown in each folder. `03-system-hardening/scripts/hardening.sh` changes SSH, services, and accounts on the machine where you run it, so keep it on the lab host.
