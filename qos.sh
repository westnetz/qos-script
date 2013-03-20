#! /bin/sh
# QoS setup

#egress

ip link set dev eth0.1999 txqueuelen 128

tc qdisc del dev eth0.1999 root
tc qdisc add dev eth0.1999 root handle 1: htb
tc class add dev eth0.1999 parent 1: classid 1:1 htb rate 19Mbit burst 25k

tc class add dev eth0.1999 parent 1:1 classid 1:2128 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev eth0.1999 parent 1:1 classid 1:2129 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev eth0.1999 parent 1:1 classid 1:2130 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev eth0.1999 parent 1:1 classid 1:2131 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev eth0.1999 parent 1:1 classid 1:2132 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev eth0.1999 parent 1:1 classid 1:2133 htb ceil 19Mbit rate 100kbit burst 25k

tc qdisc add dev eth0.1999 parent 1:2128 handle 2128: sfq 
tc qdisc add dev eth0.1999 parent 1:2129 handle 2129: sfq 
tc qdisc add dev eth0.1999 parent 1:2130 handle 2130: sfq 
tc qdisc add dev eth0.1999 parent 1:2131 handle 2131: sfq 
tc qdisc add dev eth0.1999 parent 1:2132 handle 2132: sfq 
tc qdisc add dev eth0.1999 parent 1:2133 handle 2133: sfq 

#ingress

tc qdisc del dev ifb0 root
tc qdisc add dev ifb0 root handle 1: htb
tc class add dev ifb0 parent 1: classid 1:1 htb rate 19Mbit burst 25k

tc class add dev ifb0 parent 1:1 classid 1:2128 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev ifb0 parent 1:1 classid 1:2129 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev ifb0 parent 1:1 classid 1:2130 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev ifb0 parent 1:1 classid 1:2131 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev ifb0 parent 1:1 classid 1:2132 htb ceil 19Mbit rate 100kbit burst 25k
tc class add dev ifb0 parent 1:1 classid 1:2133 htb ceil 19Mbit rate 100kbit burst 25k

tc qdisc add dev ifb0 parent 1:2128 handle 2128: sfq 
tc qdisc add dev ifb0 parent 1:2129 handle 2129: sfq 
tc qdisc add dev ifb0 parent 1:2130 handle 2130: sfq 
tc qdisc add dev ifb0 parent 1:2131 handle 2131: sfq 
tc qdisc add dev ifb0 parent 1:2132 handle 2132: sfq 
tc qdisc add dev ifb0 parent 1:2133 handle 2133: sfq 
tc qdisc add dev ifb0 parent 1:2134 handle 2134: sfq 

ip link set dev ifb0 up
ip link set dev ifb0 txqueuelen 128

tc qdisc del dev eth0.2128 root
ip link set dev eth0.2128 txqueuelen 32
tc qdisc add dev eth0.2128 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2128 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.128.0/24 \
	flowid 1:2128

tc qdisc del dev eth0.2129 root
ip link set dev eth0.2129 txqueuelen 32
tc qdisc add dev eth0.2129 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2129 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.129.0/24 \
	flowid 1:2129

tc qdisc del dev eth0.2130 root
ip link set dev eth0.2130 txqueuelen 32
tc qdisc add dev eth0.2130 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2130 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.130.0/24 \
	flowid 1:2130

tc qdisc del dev eth0.2131 root
ip link set dev eth0.2131 txqueuelen 32
tc qdisc add dev eth0.2131 root handle 1:  prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2131 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.131.0/24 \
	flowid 1:2131

tc qdisc del dev eth0.2132 root
ip link set dev eth0.2132 txqueuelen 32
tc qdisc add dev eth0.2132 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2132 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.132.0/24 \
	flowid 1:2132

tc qdisc del dev eth0.2133 root
ip link set dev eth0.2133 txqueuelen 32
tc qdisc add dev eth0.2133 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2133 parent 1:0 protocol ip priority 10 u32 match u32 0 \
	0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.133.0/24 \
	flowid 1:2133
