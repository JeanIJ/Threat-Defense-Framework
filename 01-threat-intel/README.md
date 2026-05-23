# Soc Security Assessment Project

**Author:** Jean Irakiza  
**Environment:** Linux (Kali), VirtualBox Lab, Enterprise Network Simulation  

## Project Overview
This repository serves as a comprehensive security assessment portfolio simulating an enterprise environment. It documents practical capabilities across threat intelligence mapping, synthetic phishing and malware analysis, Linux system hardening, and network security monitoring using industry-standard frameworks.

## Project Architecture

```text
├── 01-threat-intel/                # Adversary profiling & OSINT reconnaissance
│   ├── iocs/                       # Extracted Indicators of Compromise
│   └── osint/                      # Domain harvesting data
├── 02-attack-malware-analysis/     # Phishing artifacts & sandbox behavior
│   ├── phishing/                   # Email header analysis
│   └── malware-sandbox/            # Process logs & behavioral screenshots
├── 03-system-hardening/            # Endpoint configuration & access audits
│   ├── privilege-audit/            # Account & permission logs
│   └── scripts/                    # Automation scripts for hardening
└── 04-network-monitoring/          # Traffic analysis & intrusion detection
    ├── pcaps/                      # Network capture files
    ├── snort-rules/                # Custom IDS signatures
    └── network-diagram/            # Segmented defense architecture