	Networking Cheat Sheet
	======================

## IP 

### Address

32 bit => 4 byte => [0->255].[0->255].[0->255].[0->255]

### Classes

	Bit -->  0                           31            Address Range:
		+-+----------------------------+
		|0|       Class A Address      |       0.0.0.0 - 127.255.255.255
		+-+----------------------------+
		+-+-+--------------------------+
		|1 0|     Class B Address      |     128.0.0.0 - 191.255.255.255
		+-+-+--------------------------+
		+-+-+-+------------------------+
		|1 1 0|   Class C Address      |     192.0.0.0 - 223.255.255.255
		+-+-+-+------------------------+
		+-+-+-+-+----------------------+
		|1 1 1 0|  MULTICAST Address   |     224.0.0.0 - 239.255.255.255
		+-+-+-+-+----------------------+
		+-+-+-+-+-+--------------------+
		|1 1 1 1 0|     Reserved       |     240.0.0.0 - 247.255.255.255
		+-+-+-+-+-+--------------------+

### Subnetting

A subnetwork, or subnet, is a logical, visible subdivision of an IP network.
The practice of dividing a network into two or more networks is called subnetting.

An IP can be represented as a sequence of bits like that...

	| class | subnet | host |

So for instance, if you have...

	       IP Address: 192     .168     .1       .15
	Binary IP Address: 11000000.10101000.00000001.00001111

	             CIDR: 24 
	                   <-------- 24 bits ------->
	   Binary Netmask: 11111111.11111111.11111111.00000000
	          Netmask: 255     .255     .255     .0

	   Bynary Network: 11000000.10101000.00000001.00001111 (IP Address AND Netmask)
	          Network: 192     .168     .1       .0

### IP Broadcast

IP broadcasting refers to a method of transferring a message to all IPs of the subnet.

The all-ones host address of each subnet is that subnet's broadcast address.

	Binary IP Address: 11000000.10101000.00000001.00001111
	   Binary Netmask: 11111111.11111111.11111111.00000000
  BinaryBroadcast Address: 11000000.10101000.00000001.11111111 (IP Address OR NOT(Netmask))
	Broadcast Address: 192     .168     .1       .255

A special definition exists for the IP broadcast address 255.255.255.255. 
It is the broadcast address of the zero network or 0.0.0.0, which in Internet Protocol standards stands for this network, 
i.e. the local network.

### IP Multicast

IP multi-casting is a communication mechanism in which data is communicated from server 
to a set of clients who are interested in receiving that data. 

#### Multicast Address

	|1|1|1|0| 28 bit |

So range is from...

	[1110][0000 00000000 00000000 00000000] => 224.0.0.0

To...

	[1110][1111 11111111 11111111 11111111] => 239.255.255.255

#### Multicast Group

The 28 remaining bits are the "group"

        
	|1|1|1|0| <group> |

##### Well Known Multicast Groups

There are some special multicast groups, say "well known multicast groups", 
that should not be uses in your particular applications due the special purpose they are destined to.

*	224.0.0.1 is the all-hosts group. 
	*	If you ping that group, all multicast capable hosts on the network should answer, as every multicast capable host 
		must join that group at start-up on all it's multicast capable interfaces.
*	224.0.0.2 is the all-routers group. 
	*	All multicast routers must join that group on all it's multicast capable interfaces.
*	224.0.0.4 is the all DVMRP routers, 
*	224.0.0.5 the all OSPF routers, 
*	224.0.013 the all PIM routers
*	...

### Level Of Conformance

Hosts can be in three different levels of conformance with the Multicast specification, according to the requirements they meet.

*	Level 0 is the "no support for IP Multicasting" level. 
	Lots of hosts and routers in the Internet are in this state, as multicast support is not mandatory in IPv4 (it is, however, in IPv6). 
	Hosts in this level can neither send nor receive multicast packets. They must ignore the ones sent by other multicast capable hosts.
*	Level 1 is the "support for sending but not receiving multicast IP datagrams" level. 
	Thus, note that it is not necessary to join a multicast group to be able to send datagrams to it. 
	Very few additions are needed in the IP module to make a "Level 0" host "Level 1-compliant".
*	Level 2 is the "full support for IP multicasting" level. 
	Level 2 hosts must be able to both send and receive multicast traffic. 
	They must know the way to join and leave multicast groups and to propagate this information to multicast routers. 
	Thus, they must include an Internet Group Management Protocol (IGMP) implementation in their TCP/IP stack.

### Functioning

Sending

In principle, an application just needs to open a UDP socket and fill with a class D multicast address the destination address 
where it wants to send data to. 
However, there are some operations that a sending process must be able to control.

TTL

	TTL     Scope
	----------------------------------------------------------------------
	   0    Restricted to the same host. Won't be output by any interface.
	   1    Restricted to the same subnet. Won't be forwarded by a router.
	 <32    Restricted to the same site, organization or department.
	 <64    Restricted to the same region.
	<128    Restricted to the same continent.
	<255    Unrestricted in scope. Global.

Loopback.

When the sending host is Level 2 conformant and is also a member of the group datagrams are being sent to, a copy is looped back by default.
This can be turned on or off.

Interface selection.

Hosts attached to more than one network should provide a way for applications to decide which network interface will be used to output the transmissions.

Receiving Multicast Datagrams

With multicast, it is necessary to advise the kernel which multicast groups we are interested in. 
That is, we have to ask the kernel to "join" those multicast groups. 
Depending on the underlying hardware, multicast datagrams are filtered by the hardware or by the IP layer (and, in some cases, by both). 
Only those datagram with a destination group previously registered via a join are accepted.

Finally, consider that for a process to receive multicast datagrams it has to ask the kernel to join the group and bind the port 
those datagrams were being sent to. 
The UDP layer uses both the destination address and port to demultiplex the packets and decide which socket(s) deliver them to.

Leaving a Multicast Group.

When a process is no longer interested in a multicast group, it informs the kernel that it wants to leave that group.

### IP Broadcast

A transmission to all interface cards on the network.

Two types of Broadcast depending on the reached hosts:
* Limited Broadcast
	* Sent to all NICs on the some network segment as the source NIC. 
	It is represented with the 255.255.255.255 TCP/IP address. 
	This broadcast is not forwarded by routers so will only appear on one network segment.
* Direct broadcast
	* Sent to all hosts on a network. 
	Routers may be configured to forward directed broadcasts on large networks. 
	For network 192.168.0.0, the broadcast is 192.168.255.255.


