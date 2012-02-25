--- 
title: "FreeBSD : Static IP"
---

This is a simple memorandum. In order to assign a static IP to a FreeBSD
computer, just add the following to `/etc/rc.conf`:

~~~ bash
ifconfig_sk0="inet 192.168.0.42 netmask 255.255.255.0"
defaultrouter="192.168.0.1"
~~~
