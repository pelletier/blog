--- 
wordpress_id: 610
title: Virtualization as development tool
wordpress_url: http://thomas.pelletier.im/?p=610
layout: post
---
Okay, the title is not well choosen, that's because my prefered one is too long for the blog layout: Linux Virtualization for a nicer development workplace.

Why using virtualization? In my opinion, the anwser this quite simple. Today, computers are widely able to virtualize at least one operating system (the guest) *without GUI*. Consequently you can use a virtual system to run a pre-production or a testing environement, more similar to the final production system, and without spoiling your so loved work environement. In my case, I use a virtual machine which runs the exact same software as the final production server does (NGinx, Gunicorn, Django, CouchDB, RabbitMQ, Debian), so I can for example solve many deployment problems, well, before they happen! Furthermore, virtual machines *are* containted in files. Want to see what would happen if you would upgrade your production server to the latest version? Just copy your current VM, upgrade it, and see the result :)
Now that I'm sure you want to virtualize thousands of system, let take a look at the way I achieve this.

In this example, I use Ubuntu Lucid as host and Debian Lenny as guest.

First, install kvm and qemu in your Ubuntu host:

	sudo apt-get install kvm qemu

If you (like me) run an Intel-based computer, load the proper kernel module:

	sudo modprobe kvm-intel

Now let's add your user to the kvm group (you *must* run KVM machines from a user who is in the kvm group) :

	sudo adduser thomas kvm

Then create a folder for our virtualized systems:

	mkdir ~/Virtualization

Create a file which will contain our VM (here I ask it to use a dynamic-sized file: only the used space will be written on the hard disk, and it can be up to 6GB):

	qemu-img create -f qcow2 Virtualization/base.img 6G

[Download Debian Lenny](http://caesar.acc.umu.se/debian-cd/5.0.4/i386/iso-cd/debian-504-i386-netinst.iso).

Let's start the VM with the downloaded ISO mounted in the cdrom drive, and allow it 256MB of memory:

	kvm -m 256 -cdrom ~/Téléchargements/debian-504-i386-netinst.iso -boot d Virtualization/base.img

Then install Debian the way you like it.

Finally, run your VM:

	kvm -m 256 Virtualization/base.img
