--- 
title: Time Machine, FreeBSD and AFP are on a little boat
---

**Warning: This post is outdated! Here is a [newer
version](http://thomas.pelletier.im/2012/01/freebsd-afp-timemachine-updated/).**

Okay, I just had set up a backup system from a MacBookPro (let's say, the
client) to a FreeBSD-powered server (quite boringly, the server).  I chose Time
Machine because of it's nice and polished interface and its deep integration
with OSX. After a lot of (too much?) tries and spent time, I chose the AFP for
the protocol between the two machines. I decided to write this post because
there are plenty of **outdated** posts on the web concerning this setup, and
I didn't manage to hit my goal with them. So my post relates a way which works
for *me*.

## On the FreeBSD server

### AFP service

The AFP protocol is provided by NetATalk, a free AFP implementation. Let's
install it with the ports tree:

~~~ bash
cd /usr/ports/net/netatalk/ && make install clean
~~~

Add it to your configuration: add the following to `/etc/rc.conf`:

~~~ bash
netatalk_enable="YES"
afpd_enable="YES"
~~~

Define an obscure setting in `/usr/local/etc/afpd.conf`:

~~~ bash
"Time Machine" -uamlist uams_dhx2.so
~~~

Add your Time Machine share into `/usr/local/etc/AppleVolumes.default` (edit to
make it fits your needs):

~~~ bash
/storage/timemachine/    "Time Machine" allow:thomas
~~~

Finally start the service:

~~~ bash
/usr/local/etc/rc.d/netatalk start
~~~

### Howl (optional)

Howl is a free implementation of the Apple's Bonjour protocol. It is used to
spread hostnames and shares on your network. You don't really *need* it, but
I think it's smarter to use it.

Install by the ports tree:

~~~ bash
cd /usr/ports/net/howl/ && make install clean
~~~

Add to the configuration (`/etc/rc.conf`):

~~~ ini
mdnsresponder_enable="YES"
mdnsresponder_flags="-f /usr/local/etc/mDNSResponder.conf"
~~~

Create the configuration file `/usr/local/etc/mDNSResponder.conf` and fill it:

~~~ bash
"Home Time Machine Server"     _afpovertcp._tcp     local.     548
~~~

Start the service:

~~~ bash
/usr/local/etc/rc.d/mdnsresponder start
~~~

## Needed steps on the client

### Unsupported Network Volumes

By default, Time Machine only allows you to use an AirPort-based system if you
want to backup your data throught your network. So we need to ask it politely
to enable the support for every network drive. Grab your terminal and type:

~~~ bash
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
~~~

### The sparsebundle image

[source of this part](http://jakub.fedyczak.net/post/28)

Since filesystem provided by FreeBSD is not quite compatible with Time Machine,
you have to create your own file system image. Use Disk Utility to create
image:

 - Save As: MachineNameMacAddress (MachineName as read from "System Preferences
   / Sharing / Computer Name field". MacAddress has to be ethernet address of
   en0 - as displayed in `ifconfig en0` result in ethernet line - without
   colons. For example: `jf010203040506`. Always use ethernet interface.
   Wireless interface won't work.)
 - Name: Time Machine
 - Size: Custom - greater than your HD size (in fact, it's the amount of disk
   space you want to allow to your backups)
 - Format: I use Mac OS Extended (Journaled) but I'm not sure which one is the
   best.
 - Partitions: Single partition - Apple partition map
 - Image format: sparse bundle disk image

Resulting file should have .sparsebundle extension. Copy it to your remote
FreeBSD drive and you're done.
