# PCAP Analysis Notes

**File:** `suspicious-traffic.pcap` (simulated)  
**Size:** 14.2 MB  
**Packets:** 12,847  

## How to Analyze
```bash
# Open in Wireshark
wireshark suspicious-traffic.pcap

# Or analyze with tshark
tshark -r suspicious-traffic.pcap -Y "dns" | head -20
tshark -r suspicious-traffic.pcap -Y "http.request" -T fields -e ip.src -e http.host
```

## Key Filters Used
- `ip.src == 192.168.255.10` — Attacker/C2 traffic
- `tcp.flags.syn == 1 and tcp.flags.ack == 0` — SYN scan detection
- `dns.qry.name contains "lab-synth"` — C2 domain queries
- `ssl.handshake.type == 1` — TLS Client Hello (beaconing)
- `icmp && frame.len > 1200` — ICMP tunneling

## Observations
- 47 SYN packets to sequential ports = port scan
- 23 DNS queries to `cdn-updates.lab-synth.net` = C2 beacon
- 1 sustained HTTPS upload = data exfiltration
- 12 oversized ICMP packets = possible tunneling test
