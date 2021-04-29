# abb-test

## Contents

ansible script ansible/setup.yml

* install tools
* install XFCE and graphic tools like Chromium
* Install the Docker stack and the Docker Compose
* Checkout this repo and a Grafana + InfluxDB stack
* Start the Grafana and InfluxDB containers

bash script located in scripts/check.sh

* get network informations
* store it in the InfluxDB

### Question 4

The problem could be found in:

* the routing table: the network 10.2.3.0 may not be correctly routed through the VPN
* the /32 network specified is not a network but a single host (that should be /24 o a bigger one
* the database port could not be exposed to the network. You can use a SSH tunnel as a workaround if the SSH server is available
* The VPN is routed and the VPN server can't forward the traffic from the VPN through the internal network
* There is an authentication error. The authentication on many dbs is based on user/pass/ip so, if the VPN is routed you should grant the IP of the VPN server instead of the range of the VPN.

Diagnose:

* ping the DB host and the VPN server
* traceroute to the DB host and the VPN server
* check the routing table (ip r show | route -n)
