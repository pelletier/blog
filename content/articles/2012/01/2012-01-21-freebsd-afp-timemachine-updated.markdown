---
title: FreeBSD, AFP, Time Machine
layout: post
---

About two years ago, I wrote [a post][] about setting up an AFP server to host
a Time Machine backup on a FreeBSD box. However time passed and Netatalk (the
software which provide the AFP server) and the AFP specfication evolved, making
the first article outdated. So here is a brand new version based on the remarks
[Jörg Wunsch][] and the commenters sent me. This configuration has been tester
on a FreeBSD 8.2 running on VirtualBox, and a Mac OS 10.7 (Lion) client.


## On the FreeBSD server

I assume you have a working FreeBSD installation and the ports tree.

First, let's start by installing Netatalk (as root):

~~~ bash
cd /usr/ports/net/netatalk/ && make install clean
~~~

Now add the following to your `/etc/rc.conf` file:

~~~ bash
netatalk_enable="YES"
afpd_enable="YES"
cnid_metad_enable="YES"
~~~

(*For those who read the old post:* note the new `cnid_metad_enable` setting)

It is time to add a line to `/usr/local/etc/AppleVolumes.default`. Assuming you
want to share the folder `/home/thomas/tm/` as `Time machine` to the UNIX user
`thomas`:

~~~ bash
/home/thomas/tm/ "Time Machine" allow:thomas cnidscheme:dbd options:usedots,upriv,tm
~~~

(*For those who read the old post:* note the new options and the `cnidscheme`
argument ; they are required!)

Finally add the following to `/usr/local/etc/afpd.conf` (making the same
assumptions as before):

~~~ bash
"Time Machine" -uamlist uams_dhx2_passwd.so
~~~

You are ready to go!

## On the client side

*(If you've read the old version, you may have noticed the "Howl" section
disappeared. In fact, new versions of Netatalk implement the Apple's Bonjour
protocol.)*

By default, Time Machine only allows you to use an AirPort-based system if you
want to backup your data throught your network. So we need to ask it politely
to enable the support for every network drive. Grab your terminal and type:

~~~ bash
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
~~~

You also need to create a disk image in order to make Time Machine happy with
your disk share. Open a terminal, `cd` to the correct `/Volumes/Time\ Machine`
directory and fire

~~~ bash
hdiutil create -size 512g -fs HFS+J -volname "Time Machine" `grep -A1 LocalHostName /Library/Preferences/SystemConfiguration/preferences.plist | tail -n1 | awk 'BEGIN { FS = "|" } ; { print $2 }'`_`ifconfig en0 | grep ether | awk 'BEGIN { FS = ":" } ; {print $1$2$3$4$5$6}' | awk {'print $2'}`.sparsebundle
~~~

*(Source: [Steffen L. Norgren][])*

Basically, this command create a 512 GB journaled HFS+ sparsebundle image named
after your machine name and the MAC address of your `en0` network interface.

## Conclusion

That should be enough – it worked for me. If you think a point needs more
explanations, or if you can't make it work, please send me an email: I would be
more than happy to help to figure out a solution!

[a post]: http://thomas.pelletier.im/2010/01/time-machine-freebsd-and-afp-are-on-a-little-boat/
[Jörg Wunsch]: http://www.sax.de/~joerg/
[Steffen L. Norgren]: http://www.trollop.org/2011/07/23/os-x-10-7-lion-time-machine-netatalk-2-2/
