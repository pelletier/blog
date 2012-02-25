--- 
title: WakeOnLan sur un serveur Debian
---

Continuation des articles sur la mise en place d'un serveur Debian.

C'est partit pour la mise en place du système WOL (WakeOnLan) sur le serveur.
Avant de commencer, vous devez vous assurer que votre carte-mère et votre carte
réseau supportent le WOL et que cette fonction est bien activée dans le BIOS.
C'est chose faite pour moi.

Premièrement, il nous faut installer les ethtool :

~~~ bash
aptitude install ethtool
~~~

Une fois que l'installation est terminée, vous devez l'exectuer avec le nom de
votre interface réseau WOL (eth1 chez moi) en argument :

~~~ bash
ethtool eth1
~~~

Normalement, vous devez avoir une sortie de ce type :

~~~ bash
homeNAS:~# ethtool eth1
Settings for eth1:
       Supports Wake-on: g
       Wake-on: d
       Link detected: yes
~~~

Le "d" à la ligne Wake-on veut dire que la fonction WOL n'est pas activée sur
la carte. Nous allons donc remédier à cela :

~~~ bash
ethtool -s eth1 wol g
~~~

Normalement, si vous refaites la première commande, votre sortie devrait être :

~~~ bash
homeNAS:~# ethtool eth1
Settings for eth1:
       Supports Wake-on: g
       Wake-on: **g**
       Link detected: yes
~~~

Maintenant que cette fonction est activée, il vous faut l'adresse physique
(MAC) de votre interface. Pour l'obtenir, dans mon cas, ça donne :

~~~ bash
homeNAS:~# ifconfig eth1 | grep HWaddr
eth1      Link encap:Ethernet  HWaddr **00:02:b3:09:76:bc**
~~~

Remplacez bien sûr eth1 par le nom de votre interface. L'adresse MAC est la
série de doublets que j'ai mis en gras ici. Ensuite, utilisez votre le client
WOL de votre choix (j'utilise wakeonlan sous Ubuntu) pour allumer votre serveur
à distance !
