#!/bin/bash

# ===== COLORS =====
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

clear
cat art.sh

while true; do
	echo
	echo -ne "${CYAN}${BOLD}ENTER DOMAIN/IP (PRESS Q TO EXIT) : ${RESET}"
	read command

	[[ "$command" == "q" || "$command" == "quit" ]] && break
	[[ -z "$command" ]] && echo -e "${RED}NO IP/COMMAND. TRY AGAIN.${RESET}" && continue

	if [[ "$command" == "1 "* ]]; then
		target="${command#1 }"
		echo -e "${GREEN}===== QUICK SCAN: '$target' =====${RESET}"
		nmap -F "$target"

	elif [[ "$command" == "2 "* ]]; then
		target="${command#2 }"
		echo -e "${GREEN}===== FULL PORT SCAN: '$target' =====${RESET}"
		nmap -p- "$target"

	elif [[ "$command" == "3 "* ]]; then
		target="${command#3 }"
		echo -e "${GREEN}===== VERSION SCAN: '$target' =====${RESET}"
		nmap -sV "$target"

	elif [[ "$command" == "4 "* ]]; then
		target="${command#4 }"
		echo -e "${GREEN}===== OS DETECTION: '$target' =====${RESET}"
		nmap -O "$target"

	elif [[ "$command" == "5 "* ]]; then
		target="${command#5 }"
		echo -e "${GREEN}===== PING SCAN: '$target' =====${RESET}"
		nmap -sn "$target"

	elif [[ "$command" == "6 "* ]]; then
		target="${command#6 }"
		echo -e "${GREEN}===== NETWORK RANGE: '$target' =====${RESET}"
		nmap "$target/24" -sn -oA tnet | grep for | cut -d " " -f5

	elif [[ "$command" == "7 "* ]]; then
		target="${command#7 }"
		echo -e "${GREEN}===== HOST LIST SCAN: '$target' =====${RESET}"
		nmap -F -iL "$target" | grep open

	elif [[ "$command" == "8 "* ]]; then
		target="${command#8 }"
		echo -e "${GREEN}===== ICMP/PACKET TRACE: '$target' =====${RESET}"
		nmap "$target" -sn -PE --packet-trace

	elif [[ "$command" == "9 "* ]]; then
		target="${command#9 }"
		echo -e "${GREEN}===== ARP PING SCAN: '$target' =====${RESET}"
		nmap "$target" -sn -PE --packet-trace --disable-arp-ping

	elif [[ "$command" == "10 "* ]]; then
		target="${command#10 }"
		echo -e "${GREEN}===== CONNECT SCAN: '$target' =====${RESET}"
		nmap "$target" --packet-trace --disable-arp-ping -Pn -n --reason -sT

	elif [[ "$command" == "11 "* ]]; then
		target="${command#11 }"
		echo -e "${GREEN}===== DEFAULT SCRIPT SCAN: '$target' =====${RESET}"
		nmap "$target" -sC

	elif [[ "$command" == "12 "* ]]; then
		target="${command#12 }"
		echo -e "${GREEN}===== AGGRESSIVE SCAN: '$target' =====${RESET}"
		nmap "$target" -A -sC

	elif [[ "$command" == "13 "* ]]; then
		target="${command#13 }"
		echo -e "${GREEN}===== VULNERABILITY SCAN: '$target' =====${RESET}"
		nmap "$target" -sV --script vuln

	elif [[ "$command" == "14 "* ]]; then
		target="${command#14 }"
		echo -e "${GREEN}===== BRUTE FORCE SCAN: '$target' =====${RESET}"
		nmap "$target" -sV -p- --script brute

	elif [[ "$command" == "15 "* ]]; then
		target="${command#15 }"
		echo -e "${GREEN}===== DISCOVERY SCAN: '$target' =====${RESET}"
		nmap "$target" -sV -p- --script discovery

	elif [[ "$command" == "16 "* ]]; then
		target="${command#16 }"
		echo -e "${GREEN}===== MALWARE SCAN: '$target' =====${RESET}"
		nmap "$target" -sV -p- --script malware

	elif [[ "$command" == "17 "* ]]; then
		target="${command#17 }"
		echo -e "${GREEN}===== ACK SCAN: '$target' =====${RESET}"
		nmap "$target" --top-ports 100 -sA -Pn -n --disable-arp-ping --packet-trace

	elif [[ "$command" == "18 "* ]]; then
		target="${command#18 }"
		echo -e "${GREEN}===== SYN SCAN: '$target' =====${RESET}"
		nmap "$target" --top-ports 100 -sS -Pn -n --disable-arp-ping --packet-trace

	elif [[ "$command" == "19 "* ]]; then
		target="${command#19 }"
		echo -e "${GREEN}===== DECOY SCAN: '$target' =====${RESET}"
		nmap "$target" --top-ports 100 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5

	elif [[ "$command" == "whois "* ]]; then
		target="${command#whois }"
		echo -e "${YELLOW}===== WHOIS: '$target' =====${RESET}"
		whois "$target"

	elif [[ "$command" == "dns "* ]]; then
		target="${command#dns }"
		echo -e "${YELLOW}===== DNS LOOKUP =====${RESET}"
		nslookup "$target"

	elif [[ "$command" == "headers "* ]]; then
		target="${command#headers }"
		echo -e "${YELLOW}===== HTTP HEADERS =====${RESET}"
		curl -I "http://$target" 2>/dev/null

	elif [[ "$command" == subdomain\ * ]]; then
		target="${command#subdomain }"

		echo -e "${YELLOW}===== SUBDOMAIN ENUM =====${RESET}"

		for sub in www mail ftp admin vpn ssh dev api test staging beta; do
			result=$(host "$sub.$target" 2>/dev/null)

			if [[ -n "$result" && "$result" != *"NXDOMAIN"* ]]; then
				echo -e "${MAGENTA}[+] FOUND:${RESET} ${CYAN}$sub.$target${RESET}"
			fi
		done

	elif [[ "$command" == "help" ]]; then

	echo -e "${BOLD}${CYAN}===== COMMANDS =====${RESET}      ${MAGENTA}⠀⠀⠀⠀⠀⠀⠀⣀⢀⢀⢀⡀${RESET}"
echo -e "${GREEN} 1 <target>${RESET}  — Quick scan       ${MAGENTA}⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⡴⠰⠞⠿⠛⠁⠓⠖⠲${RESET}"
echo -e "${GREEN} 2 <target>${RESET}  — Full port scan   ${MAGENTA}⠀⠀⠀⠀⠀⠀⠀⢸⠆⢁⠶⠿⠇⠹⠁⠸⠷⠏⣈⡀${RESET}"
echo -e "${GREEN} 3 <target>${RESET}  — Version scan     ${MAGENTA}⠀⠀⠀⠀⠀⠀⡁⠴⠛⢀⡀⠀⠀⢀⠀⠀⠀⠀⡀${RESET}"
echo -e "${GREEN} 4 <target>${RESET}  — OS detection     ${MAGENTA}⠀⠀⠀⠀⠀⠠⠀⢠⣴⣿⠀⠄⠈⠉⠀⠀⢀⠀⢻⡗${RESET}"
echo -e "${GREEN} 5 <target>${RESET}  — Ping scan        ${MAGENTA}⠀⠀⠀⠀⠀⣤⠒⢺⣿⣿⣆⠙⠄⢤⠠⠔⠘⢢⣞⠋${RESET}"
echo -e "${GREEN} 6 <network>${RESET} — Network scan     ${MAGENTA}⠀⠀⠀⠀⠈⠪⡅⠲⢿⢽⣿⣿⣶⣶⣦⣶⣿⠇${RESET}"
echo -e "${GREEN} 7 <file>${RESET}    — Host list scan  ${MAGENTA}⠀⠀⠀⠀⠀⠀⠰⠆⠁⠀⢈⠉⠹⣹⠈⠁⠀⠆${RESET}"
echo -e "${GREEN} 8 <target>${RESET}  — ICMP trace       ${MAGENTA}⠀⠀⠀⠀⠀⠀⠀⠀⠃⠷⠀⠄⣤⡀⠀⣠⠠⣤⠄${RESET}"

echo -e "${GREEN} 9 <target>${RESET}  — ARP ping"
echo -e "${GREEN}10 <target>${RESET}  — Connect scan"
echo -e "${GREEN}11 <target>${RESET}  — Default scripts"
echo -e "${GREEN}12 <target>${RESET}  — Aggressive scan"
echo -e "${GREEN}13 <target>${RESET}  — Vulnerability scan"
echo -e "${GREEN}14 <target>${RESET}  — Brute force"
echo -e "${GREEN}15 <target>${RESET}  — Discovery scripts"
echo -e "${GREEN}16 <target>${RESET}  — Malware scripts"
echo -e "${GREEN}17 <target>${RESET}  — SYN SCAN"
echo -e "${GREEN}18 <target>${RESET}  — ACK SCAN"
echo -e "${GREEN}19 <target>${RESET}  — DECOY"

echo
echo -e "${BLUE}whois <target>${RESET}      — Whois lookup"
echo -e "${BLUE}headers <target>${RESET}    — HTTP headers"
echo -e "${BLUE}dns <target>${RESET}        — DNS lookup"
echo -e "${BLUE}subdomain <target>${RESET}  — Subdomain enum"

echo
echo -e "${RED}help${RESET}                — Show commands"
echo -e "${RED}q${RESET}                   — Exit"

	else
		echo -e "${RED}INVALID COMMAND. TYPE 'help'${RESET}"
	fi

done

echo -e "${MAGENTA}GOODBYE.${RESET}"
