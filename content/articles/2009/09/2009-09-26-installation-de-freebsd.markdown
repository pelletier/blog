--- 
wordpress_id: 342
title: Installation de FreeBSD
wordpress_url: http://kiznet.fr/?p=342
layout: post
---
J'ai enfin récupéré une machine pour me servir de serveur. J'aime bien Debian comme système pour serveur, cependant je veux essayer quelque chose de nouveau : FreeBSD. J'entend souvent que cette branche de BSD est très stable et performante. A tester donc !

Voila comment s'est déroulée mon arrivée sur FreeBSD :

Premièrement, je suis resté coincé plusieurs heures sur le message "No Disks Found" à l'installation. Après avoir essayé pleins de manip' décrites sur divers forum, wiki &amp; co, le problème était que le premier disque dur était le deuxième élément de mon canal IDE principal. J'ai donc ouvert le ventre de la bête, déplacé le disque sur la nappe, et relancé. L'installation s'est passée comme sur des roulettes. Enfin, façon de parler : les serveurs FTP étaient vraiment très lents hier. Heureusement, j'avais pensé à graver un DVD de la distrib, j'ai donc fait l'installation à partir de ce media : 4 minutes pour l'installation. J'en profite d'ailleurs pour souligner que l'utilitaire d'installation **sysinstall** est vraiment bien foutu. Clair et efficace. Tout ce que j'aime.

Bon, l'installation de base, c'est bien, mais un peu limité quand même. Mon premier réflexe est d'installer un firewall. J'ai pas mal galéré avec Iptables (que j'ai l'habitude d'utiliser sans problème sous Debian et Gentoo), pour finalement avoir une protection qui ne marchait pas (enfin, qui pouvait marcher, mais à coup de scripts bash "glue". J'aime moyen). Quitte à  être dans la nouveauté, autant y aller jusqu'au bout : j'utilise maintenant IPFW, un programme homologue à Iptables, mais développé par le groupe de FreeBSD. Beaucoup mieux intégré, j'ai rapidement pris en main l'outil. Bien que je ne maîtrise pas encore les subtilités, il me convient très bien pour les règles de bases que j'ai instauré.

Autre mésaventure : je ne sais pas pourquoi, mais j'ai redémarré la machine, et là, impossible de me loguer physiquement en root. Rien n'y a fait, j'ai retapé le mot de passe une bonne vingtaine de fois, rien. C'est là que j'ai découvert le mode "one user", disponible au boot. Très efficace : on accède à un shell, on monte les partitions, on réinitialise le password root et on reboot.

J'aime beaucoup la configuration centralisée dans le fichier **rc.conf**. C'est un vrai plus pour la mise en place du système à mon avis.

Au début, j'avais parlé de l'outil **sysinstall**, que j'aime beaucoup. J'ai voulu installer des logiciels (à savoir samba et lighty). La méthode est venue d'elle même avec cet outil. D'une utilisation quasi enfantine, c'est encore une fois un vrai plaisir.

J'ai installé X11 et espère pouvoir l'utiliser par via SSH. J'avoue que je n'aime pas utiliser un serveur avec une couche graphique, mais vu que cette installation est effectuée à des fins de tests, autant en profiter. Tout marche bien à ce niveau là ! Connexion SSH par échange de clés, et les applications lancés graphiquement tournent bien sous le Mac.

Pour l'instant tout va bien. La suite des installations / configurations feront l'objet de billets séparés.
