# PDT_SPINE1

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [DNS Domain](#dns-domain)
  - [IP Name Servers](#ip-name-servers)
  - [NTP](#ntp)
  - [Management SSH](#management-ssh)
  - [Management Console](#management-console)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [Enable Password](#enable-password)
  - [AAA Authorization](#aaa-authorization)
- [Monitoring](#monitoring)
  - [Logging](#logging)
  - [SNMP](#snmp)
  - [SFlow](#sflow)
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Interface Defaults](#interface-defaults)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [ACL](#acl)
  - [Standard Access-lists](#standard-access-lists)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | OOB MGMT INTERFACE | oob | MGMT | 172.16.1.101/24 | 172.16.1.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | OOB MGMT INTERFACE | oob | MGMT | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management0
   description OOB MGMT INTERFACE
   no shutdown
   vrf MGMT
   ip address 172.16.1.101/24
   no lldp transmit
   no lldp receive
```

### DNS Domain

DNS domain: Hosting_XYZ.com

#### DNS Domain Device Configuration

```eos
dns domain Hosting_XYZ.com
!
```

### IP Name Servers

#### IP Name Servers Summary

| Name Server | VRF | Priority |
| ----------- | --- | -------- |
| 208.67.222.222 | MGMT | - |
| 8.8.8.8 | MGMT | - |

#### IP Name Servers Device Configuration

```eos
ip name-server vrf MGMT 8.8.8.8
ip name-server vrf MGMT 208.67.222.222
```

### NTP

#### NTP Summary

##### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| pool.ntp.org | MGMT | - | - | True | - | - | - | - | - |
| time.google.com | MGMT | True | - | True | - | - | - | - | - |

#### NTP Device Configuration

```eos
!
ntp server vrf MGMT pool.ntp.org iburst
ntp server vrf MGMT time.google.com prefer iburst
```

### Management SSH

#### SSH Timeout and Management

| Idle Timeout | SSH Management |
| ------------ | -------------- |
| 60 | Enabled |

#### Max number of SSH sessions limit and per-host limit

| Connection Limit | Max from a single Host |
| ---------------- | ---------------------- |
| - | - |

#### Ciphers and Algorithms

| Ciphers | Key-exchange methods | MAC algorithms | Hostkey server algorithms |
|---------|----------------------|----------------|---------------------------|
| default | default | default | default |


#### Management SSH Device Configuration

```eos
!
management ssh
   idle-timeout 60
```

### Management Console

#### Management Console Timeout

Management Console Timeout is set to **30** minutes.

#### Management Console Device Configuration

```eos
!
management console
   idle-timeout 30
```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | Default Services |
| ---- | ----- | ---------------- |
| False | True | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| admin | 15 | network-admin | False | - |
| tech | 15 | network-admin | False | - |
| test | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 <removed>
username tech privilege 15 role network-admin secret sha512 <removed>
username test privilege 15 role network-admin secret sha512 <removed>
```

### Enable Password

Enable password has been disabled

### AAA Authorization

#### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | local |

Authorization for configuration commands is disabled.

#### AAA Authorization Device Configuration

```eos
aaa authorization exec default local
!
```

## Monitoring

### Logging

#### Logging Servers and Features Summary

| Type | Level |
| -----| ----- |
| Console | notifications |
| Buffer | notifications |
| Trap | debugging |

| Format Type | Setting |
| ----------- | ------- |
| Timestamp | traditional year |
| Hostname | hostname |
| Sequence-numbers | false |
| RFC5424 | False |

| VRF | Source Interface |
| --- | ---------------- |
| default | Vlan4092 |

| VRF | Hosts | Ports | Protocol |
| --- | ----- | ----- | -------- |
| default | 10.0.100.35 | Default | UDP |

#### Logging Servers and Features Device Configuration

```eos
!
logging buffered 10000 notifications
logging trap debugging
logging console notifications
logging host 10.0.100.35
logging format timestamp traditional year
logging source-interface Vlan4092
```

### SNMP

#### SNMP Configuration Summary

| Contact | Location | SNMP Traps | State |
| ------- | -------- | ---------- | ----- |
| Information Technology | Fake data center XYZ | All | Disabled |

#### SNMP Communities

| Community | Access | Access List IPv4 | Access List IPv6 | View |
| --------- | ------ | ---------------- | ---------------- | ---- |
| <removed> | ro | SNMP | - | - |

#### SNMP Device Configuration

```eos
!
snmp-server contact Information Technology
snmp-server location Fake data center XYZ
snmp-server community <removed> ro SNMP
```

### SFlow

#### SFlow Summary

| VRF | SFlow Source | SFlow Destination | Port |
| --- | ------------ | ----------------- | ---- |
| default | - | 127.0.0.1 | 6343 |
| default | Vlan4092 | - | - |

sFlow Sample Rate: 2000

sFlow Polling Interval: 20

sFlow is enabled.

#### SFlow Device Configuration

```eos
!
sflow sample 2000
sflow polling-interval 20
sflow vrf default destination 127.0.0.1
sflow vrf default source-interface Vlan4092
sflow run
```

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| PDT_DC_MAIN_SPINES | Vlan4094 | 192.168.0.1 | Port-Channel1000 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id PDT_DC_MAIN_SPINES
   local-interface Vlan4094
   peer-address 192.168.0.1
   peer-link Port-Channel1000
   reload-delay mlag 300
   reload-delay non-mlag 330
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **rapid-pvst**

#### Rapid-PVST Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 1-4094 | 8192 |

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode rapid-pvst
no spanning-tree vlan-id 4094
spanning-tree vlan-id 1-4094 priority 8192
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 10 | BLUE_NET | - |
| 20 | GREEN_NET | - |
| 30 | ORANGE_NET | - |
| 40 | RED_NET | - |
| 50 | PDT | - |
| 60 | TEST_VLAN | - |
| 70 | IOT_VLAN | - |
| 80 | AV_VLAN | - |
| 4092 | INBAND_MGMT | - |
| 4094 | MLAG | MLAG |

### VLANs Device Configuration

```eos
!
vlan 10
   name BLUE_NET
!
vlan 20
   name GREEN_NET
!
vlan 30
   name ORANGE_NET
!
vlan 40
   name RED_NET
!
vlan 50
   name PDT
!
vlan 60
   name TEST_VLAN
!
vlan 70
   name IOT_VLAN
!
vlan 80
   name AV_VLAN
!
vlan 4092
   name INBAND_MGMT
!
vlan 4094
   name MLAG
   trunk group MLAG
```

## Interfaces

### Interface Defaults

#### Interface Defaults Summary

- Default Routed Interface MTU: 1500

#### Interface Defaults Device Configuration

```eos
!
interface defaults
   mtu 1500
```

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet1 | L2_PDT_LEAF1_Ethernet1 | *trunk | *10,20,30,40,50,60,70,80,4092 | *- | *- | 1 |
| Ethernet2 | L2_PDT_LEAF2_Ethernet1 | *trunk | *10,20,30,40,50,60,70,80,4092 | *- | *- | 1 |
| Ethernet3 | L2_PDT_LEAF3_Ethernet1 | *trunk | *10,30,50,60,70,80,4092 | *- | *- | 3 |
| Ethernet4 | L2_PDT_LEAF4_Ethernet1 | *trunk | *10,30,50,60,70,80,4092 | *- | *- | 3 |
| Ethernet47 | MLAG_PDT_SPINE2_Ethernet47 | *trunk | *- | *- | *MLAG | 1000 |
| Ethernet48 | MLAG_PDT_SPINE2_Ethernet48 | *trunk | *- | *- | *MLAG | 1000 |

*Inherited from Port-Channel Interface

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description L2_PDT_LEAF1_Ethernet1
   no shutdown
   channel-group 1 mode active
!
interface Ethernet2
   description L2_PDT_LEAF2_Ethernet1
   no shutdown
   channel-group 1 mode active
!
interface Ethernet3
   description L2_PDT_LEAF3_Ethernet1
   no shutdown
   channel-group 3 mode active
!
interface Ethernet4
   description L2_PDT_LEAF4_Ethernet1
   no shutdown
   channel-group 3 mode active
!
interface Ethernet47
   description MLAG_PDT_SPINE2_Ethernet47
   no shutdown
   channel-group 1000 mode active
!
interface Ethernet48
   description MLAG_PDT_SPINE2_Ethernet48
   no shutdown
   channel-group 1000 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel1 | L2_RACK1_Port-Channel1 | trunk | 10,20,30,40,50,60,70,80,4092 | - | - | - | - | 1 | - |
| Port-Channel3 | L2_RACK2_Port-Channel1 | trunk | 10,30,50,60,70,80,4092 | - | - | - | - | 3 | - |
| Port-Channel1000 | MLAG_PDT_SPINE2_Port-Channel1000 | trunk | - | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel1
   description L2_RACK1_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,20,30,40,50,60,70,80,4092
   switchport mode trunk
   switchport
   mlag 1
!
interface Port-Channel3
   description L2_RACK2_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10,30,50,60,70,80,4092
   switchport mode trunk
   switchport
   mlag 3
!
interface Port-Channel1000
   description MLAG_PDT_SPINE2_Port-Channel1000
   no shutdown
   switchport mode trunk
   switchport trunk group MLAG
   switchport
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | ROUTER_ID | default | 192.168.255.1/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 192.168.255.1/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | BLUE_NET | default | - | False |
| Vlan20 | GREEN_NET | default | - | False |
| Vlan30 | ORANGE_NET | default | - | False |
| Vlan40 | RED_NET | default | - | False |
| Vlan50 | PDT | default | - | False |
| Vlan4092 | Inband Management | default | 1500 | False |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan10 |  default  |  10.10.10.2/24  |  -  |  10.10.10.1  |  -  |  -  |
| Vlan20 |  default  |  10.20.20.2/24  |  -  |  10.20.20.1  |  -  |  -  |
| Vlan30 |  default  |  10.30.30.2/24  |  -  |  10.30.30.1  |  -  |  -  |
| Vlan40 |  default  |  10.40.40.2/24  |  -  |  10.40.40.1  |  -  |  -  |
| Vlan50 |  default  |  10.50.50.2/24  |  -  |  10.50.50.1  |  -  |  -  |
| Vlan4092 |  default  |  192.168.161.2/24  |  -  |  192.168.161.1  |  -  |  -  |
| Vlan4094 |  default  |  192.168.0.0/31  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description BLUE_NET
   no shutdown
   ip address 10.10.10.2/24
   ip helper-address 1.2.3.6
   ip virtual-router address 10.10.10.1
!
interface Vlan20
   description GREEN_NET
   no shutdown
   ip address 10.20.20.2/24
   ip virtual-router address 10.20.20.1
!
interface Vlan30
   description ORANGE_NET
   no shutdown
   ip address 10.30.30.2/24
   ip virtual-router address 10.30.30.1
!
interface Vlan40
   description RED_NET
   no shutdown
   ip address 10.40.40.2/24
   ip virtual-router address 10.40.40.1
!
interface Vlan50
   description PDT
   no shutdown
   ip address 10.50.50.2/24
   ip virtual-router address 10.50.50.1
!
interface Vlan4092
   description Inband Management
   no shutdown
   mtu 1500
   ip address 192.168.161.2/24
   ip attached-host route export 19
   ip virtual-router address 192.168.161.1
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 192.168.0.0/31
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: aa:aa:bb:bb:cc:cc

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address aa:aa:bb:bb:cc:cc
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | False |

#### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| MGMT | 0.0.0.0/0 | 172.16.1.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 172.16.1.1
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

## ACL

### Standard Access-lists

#### Standard Access-lists Summary

##### SNMP

| Sequence | Action |
| -------- | ------ |
| 10 | permit host 10.0.100.10 |
| 20 | permit host 10.0.100.20 |
| 30 | permit host 10.0.100.30 |

#### Standard Access-lists Device Configuration

```eos
!
ip access-list standard SNMP
   10 permit host 10.0.100.10
   20 permit host 10.0.100.20
   30 permit host 10.0.100.30
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |

### VRF Instances Device Configuration

```eos
!
vrf instance MGMT
```
