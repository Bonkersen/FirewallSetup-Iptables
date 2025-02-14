#!/bin/bash
#Protection-against-portscanning
/sbin/iptables -N port-scanning
/sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
/sbin/iptables -A port-scanning -j DROP
#ssh-protection
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
/sbin/iptables -A INPUT -i eth1 -p icmp --icmp-type echo-request -j DROP
#drop-null-packets
/sbin/iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
#print-rules
/sbin/iptables -nL
