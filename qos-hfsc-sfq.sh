#! /bin/sh
# QoS setup

# egress

ip link set dev eth0.1999 txqueuelen 128

tc qdisc del dev eth0.1999 root &> /dev/null
tc qdisc add dev eth0.1999 root handle 1: hfsc default 1999
tc class add dev eth0.1999 parent 1: classid 1:1 hfsc sc rate 19Mbit ul rate 19Mbit

#default catch-all class
tc class add dev eth0.1999 parent 1:1 classid 1:1999 hfsc ls rate 1Mbit ul rate 19Mbit

tc class add dev eth0.1999 parent 1:1 classid 1:2128 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev eth0.1999 parent 1:1 classid 1:2129 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev eth0.1999 parent 1:1 classid 1:2130 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev eth0.1999 parent 1:1 classid 1:2131 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev eth0.1999 parent 1:1 classid 1:2132 hfsc ls rate 1Mbit ul rate 19Mbit

tc qdisc add dev eth0.1999 parent 1:2128 handle 2128: sfq 
tc qdisc add dev eth0.1999 parent 1:2129 handle 2129: sfq 
tc qdisc add dev eth0.1999 parent 1:2130 handle 2130: sfq 
tc qdisc add dev eth0.1999 parent 1:2131 handle 2131: sfq 
tc qdisc add dev eth0.1999 parent 1:2132 handle 2132: sfq 

# Egress classification is handled through iptables (MARKing in
# PREROUTING/CLASSIFY in POSTROUTING), as tc filter doesn't have access to the
# pre-NAT IP address.

# ingress

# ensure that the ifb module is loaded 

tc qdisc del dev ifb0 root &> /dev/null
tc qdisc add dev ifb0 root handle 1: hfsc
tc class add dev ifb0 parent 1: classid 1:1 hfsc sc rate 19Mbit ul rate 19Mbit

tc class add dev ifb0 parent 1:1 classid 1:2128 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev ifb0 parent 1:1 classid 1:2129 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev ifb0 parent 1:1 classid 1:2130 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev ifb0 parent 1:1 classid 1:2131 hfsc ls rate 1Mbit ul rate 19Mbit
tc class add dev ifb0 parent 1:1 classid 1:2132 hfsc ls rate 1Mbit ul rate 19Mbit

tc qdisc add dev ifb0 parent 1:2128 handle 2128: sfq 
tc qdisc add dev ifb0 parent 1:2129 handle 2129: sfq 
tc qdisc add dev ifb0 parent 1:2130 handle 2130: sfq 
tc qdisc add dev ifb0 parent 1:2131 handle 2131: sfq 
tc qdisc add dev ifb0 parent 1:2132 handle 2132: sfq 

ip link set dev ifb0 up
ip link set dev ifb0 txqueuelen 128

tc qdisc del dev eth0.2128 root &> /dev/null
ip link set dev eth0.2128 txqueuelen 32
tc qdisc add dev eth0.2128 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2128 parent 1:0 protocol ip priority 10 u32 match u32 0 \
        0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.128.0/24 \
        flowid 1:2128

tc qdisc del dev eth0.2129 root &> /dev/null
ip link set dev eth0.2129 txqueuelen 32
tc qdisc add dev eth0.2129 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2129 parent 1:0 protocol ip priority 10 u32 match u32 0 \
        0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.129.0/24 \
        flowid 1:2129


tc qdisc del dev eth0.2130 root &> /dev/null
ip link set dev eth0.2130 txqueuelen 32
tc qdisc add dev eth0.2130 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2130 parent 1:0 protocol ip priority 10 u32 match u32 0 \
        0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.130.0/24 \
        flowid 1:2130

tc qdisc del dev eth0.2131 root &> /dev/null
ip link set dev eth0.2131 txqueuelen 32
tc qdisc add dev eth0.2131 root handle 1:  prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2131 parent 1:0 protocol ip priority 10 u32 match u32 0 \
        0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.131.0/24 \
        flowid 1:2131

tc qdisc del dev eth0.2132 root &> /dev/null
ip link set dev eth0.2132 txqueuelen 32
tc qdisc add dev eth0.2132 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc filter add dev eth0.2132 parent 1:0 protocol ip priority 10 u32 match u32 0 \
        0 flowid 1: action mirred egress redirect dev ifb0
tc filter add dev ifb0 parent 1:0 protocol ip u32 match ip dst 172.19.132.0/24 \
        flowid 1:2132
