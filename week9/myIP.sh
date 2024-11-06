#ip -o a show dev ens160 | grep -i "inet" | grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | head -n1
ip addr show dev ens160 | awk '/inet / {print $2}'
