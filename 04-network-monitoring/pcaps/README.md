# PCAP Analysis Notes - REAL CAPTURE

**File:** `real-traffic.pcap`
**Size:** 45 KB
**Packets:** 100
**Captured by:** `tcpdump -i any -c 100` on Kali Linux VM

## Protocol Breakdown
```text
Protocol Hierarchy Statistics:
- frame: 100 packets, 44,209 bytes
- ip: 100 packets
-  ud`: 17 packets (2.529 bytes)
-    dns: 17 packets
-  tcp: 83 packets (41,680 bytes)
-   tls: 45 packets (36,360 bytes)
```

## IPv4 Conversations

| Source | Destination | Frames | Bytes | Note |
|-------|-----------|--------|------|-------|
| 10.0.2.15 | 142.251.150.119 | 52 | 27 KB | Google CDN (GStatic) |
| 10.0.2.15 | 10.0.2.3 | 17 | 2.5 KB | GATEWAY (DNS) - VirtualBox |
| 10.0.2.15 | 142.250.189.110 | 17 | 5.7 KB | YouTube |
| 10.0.2.15 | 142.251.41.67 | 14 | 8 KB | Google service |

## DNS Queries Discovered

```text
www.google.com
www.youtube.com
www.gstatic.com
```

## How to Analyze in Wireshark
```bash
wireshark 04-network-monitoring/pcaps/real-traffic.pcap

or

tshark -r 04-network-monitoring/pcaps/real-traffic.pcap -Y "dns" | head -20
tshark -r 04-network-monitoring/pcaps/real-traffic.pcap -Y "http.request" -T fields -e ip.src -e http.host
```

## Key Filters Used
- `ip.src == 10.0.2.15` — Local VM traffic
- `tcp.flags.syn == 1 and tcp.flags.ack == 0` — SYN scan detection
- `dns.qry.name contains "google"` — Dns queries
- `tls.ct.length > 1000` — Large TLS data exchanges

## Observations
- 100 packets captured over 2.7 seconds
- Dominant traffic is TLS (HTTPS) to Google/YouTube services
- DNS queries to www.google.com, www.youtube.com, www.gstatic.com
- No suspicious port scanning detected
- No UNUSUAL protocol behavior observed
- All traffic is legitimate (no malicious IOCs)

## Recommendations
1. Baseline normal traffic for this VM so future deviations can be detected
2. Monitor for UNKNOWN DNS queries (potential CC domain)

