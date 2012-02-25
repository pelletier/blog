--- 
wordpress_id: 23
title: Installation d'un serveur SSH sous Debian
wordpress_url: http://kiznet.fr/blog/2009/03/29/installation-dun-serveur-ssh-sous-debian/
layout: post
---

Voilà le premier article qui fait suite à celui du [récit de l'installation du
système de base
Debian](http://kizlum.wordpress.com/2009/03/29/recit-installation-dune-debian-pour-un-serveur/).

Nous allons ici mettre en place un serveur SSH afin de pouvoir administrer la
machine à distance et pouvoir continuer son installation sans avoir à changer
de clavier.

*Toute la procédure est faite en tant qu'utilisateur root ! J'utilise VIM
comme éditeur de texte (pour les fichiers de conf), mais vous pouvez évidement
le remplacer par l'éditeur de votre choix.*

Premièrement, nous devons installer le logiciel serveur. J'ai l'habitude d'utiliser openssh, l'installation se fait donc par la ligne :

`aptitude install openssh-server`

Le logiciel est installé, il faut maintenant passer à la modification des
fichiers de configuration pour des raisons de sécurité.

Ouvrez le fichier **/etc/ssh/sshd_config**. J'interdis la connexion directement en tant que root : je modifie la ligne suivante :
`PermitRootLogin no`
Ensuite, je rajoute la ligne :
`AllowUsers kizlum`
pour n'autoriser que mon compte à se connecter en SSH (je suis le seul à être administrateur, il n'y a donc aucune raison que quelqu'un d'autre se connecte en SSH).

Pour prendre en compte directement les modifications, je relance le service :

`/etc/init.d/ssh restart`

Bien. Le serveur est maintenant opérationnel. Cependant, je préfère une connexion par clé privé / clé publique plutôt qu'une simple connexion par mot de passe.

*Les commandes ci-dessous sont à entrer sur votre CLIENT, et pas sur le serveur, avec les droits de votre utilisateur habituel !*

Création de la clé privé et de la clé publique :
`ssh-keygen -t dsa`
Entrez votre passphrase (genre un truc un peu long). lorsqu'il demande où enregistrer id_dsa, j'ai choisis de laisser l'emplacement par défaut. Une fois la clé crée, il faut ensuite l'exporter sur le serveur distant :
`ssh-copy-id -i ~/.ssh/id_dsa.pub votreuser@adressedevotreserveurssh`
A partir de là, la passphrase vous sera toujours demander à chaque connexion SSH. Cependant, il y a moyen de ne plus la taper grâce à la commande :
`ssh-add`
Une fois que vous avez fait mémoriser à votre client la passphrase avec ssh-add, vous pouvez vous connecter en SSH à votre serveur comme avant :) .
