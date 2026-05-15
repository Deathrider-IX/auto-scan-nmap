#!/bin/bash


cat art.sh
while true; do 
	echo
	read -p "ENTER DOMAIN/IP (PRESS Q TO EXIT) : " command
	

	[[ "$command" == "q" || "$command" == "quit" ]] && break
	[[ -z "$command" ]] && echo "NO IP/DOMMAND. TRY AGAIN." && continue

	if [[ "$command" == "1 "* ]]; then
		target="${command#1 }"
		echo " =====QUICK SCAN: '$target'===="
		nmap -F "$target"


	elif [[ "$command" == "2 "* ]]; then
		target="${command#2 }"
		echo "==== FULL PORT SCAN: '$target'===="
		nmap -p- "$target"

	elif [[ "$command" == "3 "* ]]; then
		target="${command#3 }"
		echo "===== VERSION SCAN: '$target'====="
		nmap -sV "$target"

	elif [[ "$command" == "4 "* ]]; then
		target="${command#4 }"
		echo "=====OS DETECTION: '$target'====="
		nmap -O "$target"

	elif [[ "$command" == "5 "* ]]; then
		target="${command#5 }"
		echo "======PING SCAN: '$target'====="
		nmap -sn "$target"
		
	elif [[ "$command" == "6 "* ]]; then
		target="${command#6 }"
		echo "NETWORK RANGE : '$target'"
		nmap "$target/24" -sn -oA tnet | grep for | cut -d " " -f5
		
	elif [[ "$command" == "7 "* ]]; then
		target="${command#7 }"
		echo " HOST LIST SCAN : '$target'"
		nmap -F -iL "$target" | grep open

	elif [[ "$command" == "8 "* ]]; then
		target="${command#8 }"
		echo "ICMP/PACKET TRACING : '$target'"
		nmap "$target" -sn -PE --packet-trace

	elif [[ "$command" == "9 "* ]];then
		target="${command#9 }"
		echo "ARP PING SCAN: '$target'"
		nmap "$target" -sn -PE --packet-trace --disable-arp-ping

	elif [[ "$command" == "10 "* ]];then
		target="${command#10 }"
		echo "CONNECT SCAN : '$target'"
		nmap "$target" --packet-trace --disable-arp-ping -Pn -n --reason -sT

	elif [[ "$command" == "11 "* ]];then
		target="${command#11 }"
		echo "DEFAULT SCRIPT : '$target'"
		nmap "$target" -sC

	elif [[ "$command" == "12 "* ]];then
		target="${command#12 }"
		echo "TRACEROUTE, SERVICE DETECTION SCAN : '$target'"
		nmap "$target" -A -sC

	elif [[ "$command" == "13 "* ]];then
		target="${command#13 }"
		echo " VULNERABILITY SCAN : '$target'"
		nmap "$target" -sV --script vuln

	elif [[ "$command" == "14 "* ]];then
		target="${command#14 }"
		echo "BRUTE FORCE : '$target'"
		nmap "$target" -sV -p- --script brute
		
     elif [[ "$command" == "15 "* ]];then
		target="${command#15 }"
		echo "DISCOVERY : '$target'"
		nmap "$target" -sV -p- --script discovery
		
	elif [[ "$command" == "16 "* ]];then
		target="${command#16 }"
		echo "MALWARE: '$target'"
		nmap "$target" -sV -p- --script malware

	elif [[ "$command" == "whois "* ]];then
		target="${command#whois }"
		echo " WHOIS : '$target'"
		whois "$target"
	
	elif [[ "$command" == "dns "* ]];then
		target="${command#dns }"
		echo " ===DNS===="
		nslookup "$target"
		

	elif [[ "$command" == "headers "* ]];then
		target="${command#headers }"
		echo " ====== HTTP HEADER ======="
		curl -I "http://$target" 2>/dev/null

	elif [[ "$command" == subdomain\ * ]]; then
        target="${command#subdomain }"

        for sub in www mail ftp admin vpn ssh dev api test staging beta; do
            result=$(host "$sub.$target" 2>/dev/null)

            if [[ -n "$result" && "$result" != *"NXDOMAIN"* ]]; then
                echo "[+] FOUND: $sub.$target"
            fi
        done
		
		elif [[ "$command" == "help" ]]; then
    echo "===== COMMANDS ====="
    echo
    echo "  1 <target>           — Quick scan"
    echo "  2 <target>           — Full port scan"
    echo "  3 <target>           — Version scan"
    echo "  4 <target>           — OS detection"
    echo "  5 <target>           — Ping scan"
    echo "  6 <network>          — Network range scan"
    echo "  7 <file>             — Host list scan"
    echo "  8 <target>           — ICMP packet trace"
    echo "  9 <target>           — ARP ping scan"
    echo " 10 <target>           — Connect scan"
    echo " 11 <target>           — Default scripts"
    echo " 12 <target>           — Aggressive scan"
    echo " 13 <target>           — Vulnerability scan"
    echo " 14 <target>           — Brute force scripts"
    echo " 15 <target>           — Discovery scripts"
    echo " 16 <target>           — Malware scripts"
    echo
    echo "  whois <target>        — Whois lookup"
    echo "  headers <target>      — HTTP headers"
    echo "  dns <target>          — DNS lookup"
    echo "  subdomain <target>    — Subdomain enum"
    echo
    echo "  help                  — Show commands"
    echo "  q                     — Exit"
		

	else
		echo "INVALID COMMAND. TYPE 'help'"
	fi

done

echo "GOODBYE."



		
		



		
