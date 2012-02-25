--- 
title: Adresse IP locale statique sous Debian
---

Pré requis :

- Avoir une connexion réseau fonctionnelle.
- Disposer d'un accès root.

Dans cet exemple, je souhaite assigner l'adresse `192.168.0.20` à ma machine.
Mon routeur est à l'adresse `192.168.0.1`. De plus, ma carte réseau a comme nom
`eth0`.

1. Récupérer les infos de la connexion actuellement en fonctionnement.
   Normalement on en aura pas besoin, mais ça peut toujours servir : `ifconfig
   eth0 > info`. Ainsi, le fichier `info` contient tout ce qu'il vous faut
   savoir sur votre connexion.
2. La configuration se fait dans le fichier `/etc/network/interfaces`. Par
   défaut, votre carte est configurée en `DHCP`. Il doit donc y avoir une ligne
   de type `iface eth0 inet dhcp`. Commentez-la en ajoutant un `#` devant.
3. Maintenant, il faut rajouter en dessous (toujours dans ce fichier
   `interfaces`) les infos nécessaires à la carte pour se connecter :
~~~ text
iface eth0 inet static
    address 192.168.0.20
    netmask 255.255.255.0
    gateway 192.168.0.1
~~~
   Bien sûr, adaptez ces lignes à votre configuration fonctionnelle (que vous
   avez sauvegardé dans l'étape 1)
4. Redémarrer la carte : `ifdown eth0 && ifup eth0`.

Et voila. Vous pouvez vérifier avec la commande `ifconfig`.
