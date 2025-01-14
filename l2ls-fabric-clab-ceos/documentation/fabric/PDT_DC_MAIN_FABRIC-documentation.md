# PDT_DC_MAIN_FABRIC

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF1 | 172.16.1.105/24 | cEOS-LAB | Provisioned | - |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF2 | 172.16.1.106/24 | cEOS-LAB | Provisioned | - |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF3 | 172.16.1.107/24 | cEOS-LAB | Provisioned | - |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF4 | 172.16.1.108/24 | cEOS-LAB | Provisioned | - |
| PDT_DC_MAIN_FABRIC | l3spine | PDT_SPINE1 | 172.16.1.101/24 | cEOS-LAB | Provisioned | - |
| PDT_DC_MAIN_FABRIC | l3spine | PDT_SPINE2 | 172.16.1.102/24 | cEOS-LAB | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF1 | 192.168.161.4/24 | Vlan4092 |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF2 | 192.168.161.5/24 | Vlan4092 |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF3 | 192.168.161.6/24 | Vlan4092 |
| PDT_DC_MAIN_FABRIC | leaf | PDT_LEAF4 | 192.168.161.7/24 | Vlan4092 |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| leaf | PDT_LEAF1 | Ethernet1 | l3spine | PDT_SPINE1 | Ethernet1 |
| leaf | PDT_LEAF1 | Ethernet2 | l3spine | PDT_SPINE2 | Ethernet1 |
| leaf | PDT_LEAF1 | Ethernet47 | mlag_peer | PDT_LEAF2 | Ethernet47 |
| leaf | PDT_LEAF1 | Ethernet48 | mlag_peer | PDT_LEAF2 | Ethernet48 |
| leaf | PDT_LEAF2 | Ethernet1 | l3spine | PDT_SPINE1 | Ethernet2 |
| leaf | PDT_LEAF2 | Ethernet2 | l3spine | PDT_SPINE2 | Ethernet2 |
| leaf | PDT_LEAF3 | Ethernet1 | l3spine | PDT_SPINE1 | Ethernet3 |
| leaf | PDT_LEAF3 | Ethernet2 | l3spine | PDT_SPINE2 | Ethernet3 |
| leaf | PDT_LEAF3 | Ethernet47 | mlag_peer | PDT_LEAF4 | Ethernet47 |
| leaf | PDT_LEAF3 | Ethernet48 | mlag_peer | PDT_LEAF4 | Ethernet48 |
| leaf | PDT_LEAF4 | Ethernet1 | l3spine | PDT_SPINE1 | Ethernet4 |
| leaf | PDT_LEAF4 | Ethernet2 | l3spine | PDT_SPINE2 | Ethernet4 |
| l3spine | PDT_SPINE1 | Ethernet47 | mlag_peer | PDT_SPINE2 | Ethernet47 |
| l3spine | PDT_SPINE1 | Ethernet48 | mlag_peer | PDT_SPINE2 | Ethernet48 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 192.168.255.0/30 | 4 | 2 | 50.0 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| PDT_DC_MAIN_FABRIC | PDT_SPINE1 | 192.168.255.1/32 |
| PDT_DC_MAIN_FABRIC | PDT_SPINE2 | 192.168.255.2/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
