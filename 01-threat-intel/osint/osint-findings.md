# OSINT Reconnaissance Report
**Target Domain:** microsoft.com
  
**Date:** 2026-05-22
**Analyst:** Jean Irakiza

## 1. Tools Used
- *theHarvester* - domain harvesting tool
- *sources:** crtsh, hackertarget, duckduckgo

## 2. Infrastructure Discovery
Utilized `theHarvester` to enumerate external-facing assets for the target environment.

**Discovered Hosts (569 total):**
- `1esbot.microsoft.com` — 40.118.129.241
- `account.microsoft.com` — 157.56.138.80
- `azure.microsoft.com` — 20.40.202.15
- `copilot.microsoft.com`
- `developer.microsoft.com`
- `download.microsoft.com` (103.240.232.58)
- `docs.microsoft.com` 
- `support.microsoft.com` 
- `careers.microsoft.com` 
- `learn.microsoft.com`
- `techcommunity.microsoft.com` 
- `visualstudio.microsoft.com` 
- `blogs.microsoft.com` 
- `browserdefaults.microsoft.com` 

## 3. Infrastructure Analysis
- **Mail Servers:** Multiple MTA entries (customermail, e-mails, email2) indicating extensive mailing infrastructure
- **Cloud Services:** azure.microsoft.com, copilot.microsoft.com — Cloud/application endpoints
- **Developer Portal:** docs.microsoft.com, developer.microsoft.com — high-value attack surface
- **Secure Endpoints:** Multiple `.cp.com`, `.cp.microsoft.com` entries — potential management portals
- **Content Delivery:** `download.microsoft.com`, `blcdnamil2.microsoft.com` — CDn edge nodes

## 4. Threat Surface Assessment
- Extensive external facing infrastructure (569( hosts) provides a large attack surface
- Presence of developer portals and cloud services indicates initial access vectors
- Multiple mail endpoints could be leveraged for spearphishing campaigns

## 5. Recommendations
1. Implement SPF, DKIM, DMARC for mail servers
2. Restrict developer portal access by source IP range
3. Monitor certificate transparency logs for new subdomains
4. Segment external-facing services in DNZ with restricted access
5. Enable WAF/firewall rules for unexpected subdomain discovery
