# PDT_LEAF4

## Table of Contents

- [Management](#management)
  - [Banner](#banner)
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
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
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

### Banner

#### MOTD Banner

```text
This is a super secure network, behave or you'll get in big trouble.
EOF
```

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | OOB MGMT INTERFACE | oob | MGMT | 172.16.1.108/24 | 172.16.1.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management1 | OOB MGMT INTERFACE | oob | MGMT | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management1
   description OOB MGMT INTERFACE
   no shutdown
   vrf MGMT
   ip address 172.16.1.108/24
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

#### VRFs

| VRF | Enabled | IPv4 ACL | IPv6 ACL |
| --- | ------- | -------- | -------- |
| default | True | - | - |

#### Other SSH Settings

| Idle Timeout | Connection Limit | Max from a single Host | Ciphers | Key-exchange methods | MAC algorithms | Hostkey server algorithms |
| ------------ | ---------------- | ---------------------- | ------- | -------------------- | -------------- | ------------------------- |
| 60 | - | - | default | default | default | default |

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

| HTTP | HTTPS | UNIX-Socket | Default Services |
| ---- | ----- | ----------- | ---------------- |
| False | True | - | - |

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

| VRF | Hosts | Ports | Protocol | SSL-profile |
| --- | ----- | ----- | -------- | ----------- |
| default | 10.0.100.35 | Default | UDP | - |

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
| RACK2 | Vlan4094 | 192.168.0.0 | Port-Channel1000 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id RACK2
   local-interface Vlan4094
   peer-address 192.168.0.0
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
| 1-4094 | 32768 |

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode rapid-pvst
no spanning-tree vlan-id 4094
spanning-tree vlan-id 1-4094 priority 32768
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
| 30 | ORANGE_NET | - |
| 50 | PDT | - |
| 60 | TEST_VLAN | - |
| 70 | IOT_VLAN | - |
| 80 | AV_VLAN | - |
| 4092 | PDT_INBAND_MGMT | - |
| 4094 | MLAG | MLAG |

### VLANs Device Configuration

```eos
!
vlan 10
   name BLUE_NET
!
vlan 30
   name ORANGE_NET
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
   name PDT_INBAND_MGMT
!
vlan 4094
   name MLAG
   trunk group MLAG
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet1 | L2_PDT_SPINE1_Ethernet4 | *trunk | *10,30,50,60,70,80,4092 | *- | *- | 1 |
| Ethernet2 | L2_PDT_SPINE2_Ethernet4 | *trunk | *10,30,50,60,70,80,4092 | *- | *- | 1 |
| Ethernet11 | IOT | access | 70 | - | - | - |
| Ethernet12 | IOT | access | 70 | - | - | - |
| Ethernet13 | IOT | access | 70 | - | - | - |
| Ethernet14 | IOT | access | 70 | - | - | - |
| Ethernet15 | IOT | access | 70 | - | - | - |
| Ethernet16 | End User Orange | access | 30 | - | - | - |
| Ethernet17 | End User Orange | access | 30 | - | - | - |
| Ethernet18 | End User Orange | access | 30 | - | - | - |
| Ethernet19 | End User Orange | access | 30 | - | - | - |
| Ethernet20 | End User Orange | access | 30 | - | - | - |
| Ethernet30 | SERVER_host2_eth2 | *access | *30 | *- | *- | 30 |
| Ethernet47 | MLAG_PDT_LEAF3_Ethernet47 | *trunk | *- | *- | *MLAG | 1000 |
| Ethernet48 | MLAG_PDT_LEAF3_Ethernet48 | *trunk | *- | *- | *MLAG | 1000 |

*Inherited from Port-Channel Interface

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description L2_PDT_SPINE1_Ethernet4
   no shutdown
   channel-group 1 mode active
!
interface Ethernet2
   description L2_PDT_SPINE2_Ethernet4
   no shutdown
   channel-group 1 mode active
!
interface Ethernet11
   description IOT
   no shutdown
   switchport access vlan 70
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet12
   description IOT
   no shutdown
   switchport access vlan 70
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet13
   description IOT
   no shutdown
   switchport access vlan 70
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet14
   description IOT
   no shutdown
   switchport access vlan 70
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet15
   description IOT
   no shutdown
   switchport access vlan 70
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet16
   description End User Orange
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet17
   description End User Orange
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet18
   description End User Orange
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet19
   description End User Orange
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet20
   description End User Orange
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Ethernet30
   description SERVER_host2_eth2
   no shutdown
   channel-group 30 mode active
!
interface Ethernet47
   description MLAG_PDT_LEAF3_Ethernet47
   no shutdown
   channel-group 1000 mode active
!
interface Ethernet48
   description MLAG_PDT_LEAF3_Ethernet48
   no shutdown
   channel-group 1000 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel1 | L2_PDT_DC_MAIN_SPINES_Port-Channel3 | trunk | 10,30,50,60,70,80,4092 | - | - | - | - | 1 | - |
| Port-Channel30 | SERVER_host2 | access | 30 | - | - | - | - | 30 | - |
| Port-Channel1000 | MLAG_PDT_LEAF3_Port-Channel1000 | trunk | - | - | MLAG | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel1
   description L2_PDT_DC_MAIN_SPINES_Port-Channel3
   no shutdown
   switchport trunk allowed vlan 10,30,50,60,70,80,4092
   switchport mode trunk
   switchport
   mlag 1
!
interface Port-Channel30
   description SERVER_host2
   no shutdown
   switchport access vlan 30
   switchport mode access
   switchport
   mlag 30
   spanning-tree portfast
   spanning-tree bpduguard enable
!
interface Port-Channel1000
   description MLAG_PDT_LEAF3_Port-Channel1000
   no shutdown
   switchport mode trunk
   switchport trunk group MLAG
   switchport
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan4092 | PDT INBAND MGMT | default | 1500 | False |
| Vlan4094 | MLAG | default | 9214 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan4092 |  default  |  192.168.161.7/24  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  192.168.0.1/31  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan4092
   description PDT INBAND MGMT
   no shutdown
   mtu 1500
   ip address 192.168.161.7/24
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 9214
   no autostate
   ip address 192.168.0.1/31
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | False |

#### IP Routing Device Configuration

```eos
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
| default | 0.0.0.0/0 | 192.168.161.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route 0.0.0.0/0 192.168.161.1
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
