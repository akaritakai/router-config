router-config
=============

Secure router configuration for Ubuntu 14.04

The purpose of this configuration is to provide a secure router that provides several advanced features such as
  1. Listening on any number of WAN addresses
  2. Providing tarpit protection to all incoming ports
  3. Allow outbound traffic for a host to appear to come from a specific WAN address
  4. Provide port forwarding
  5. Provide routing/NAT
  6. Provide DHCP/DNS services

The primary use case for this configuration is a collection of VMs which need to host publically facing services where there are fewer public IP addresses than VMs.

Another use case is having more public IP addresses than VMs and wanting to obscure where critical services are by making it discouraging for an attacker to enumerate your network.

In addition to configuring the server as specified by the configuration files in this directory, you will have to install a number of packages

```sh
# Install NTP server
apt-get install -f -y ntp
# Install DNS server
apt-get install -f -y bind9 bind9utils 
# Install DHCP server
apt-get install -f -y isc-dhcp-server
# Install iptables management
apt-get install -f -y firehol
apt-get install -f -y xtables-addons-common xtables-addons-dkms
```
