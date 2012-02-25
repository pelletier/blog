--- 
wordpress_id: 70
title: Installation de virtualbox (officiel) sous Ubuntu Hardy Heron (8.04)
wordpress_url: http://kiznet.fr/blog/2008/11/21/installation-de-virtualbox-officiel-sous-ubuntu-hardy-heron-8.04/
layout: post
---

Voici une petite méthode pour l'installation de VirtualBox:

 1) Vérifiez d'avoir un `/etc/apt/sources.list` fonctionnel.
 2) Ajoutez la ligne suivante à votre fichier `/etc/apt/sources.list`: `deb http://www.virtualbox.org/debian gutsy non-free`.
 3) Mettez à jour la liste des packages avec la commande `sudo apt-get udpate`.
 4) Installez Virtualbox : `sudo apt-get install virtualbox`.
 5) Suivez les consignes.
 6) Ajoutez votre utilisateur au groupe virtualbox : `adduser votrenom virtualbox`.
 7) Déconnectez et reconnectez vous, le tour est joué !
