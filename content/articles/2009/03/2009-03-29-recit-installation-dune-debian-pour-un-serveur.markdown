--- 
title: "Récit : installation d'une Debian pour un serveur"
---

Bien, je vais ici raconter ma petite histoire d'installation d'un serveur
perso. Pour être plus précis, de l'installation d'un système de base Debian,
l'installation du serveur en lui même va se faire en plusieurs temps dans des
billets séparés. Je vais passer les détails concernant la quête des divers
composant. Au final, je me retrouve avec un PIII 650MHz 60Go de disque dur et
192 Mo de RAM (et un lecteur DVD de base).

Premièrement : choisir sa distrib à installer et préparer un CD. Moi choix
s'est encore porté sur une Debian (5.0, stable). Je télécharge l'ISO de la
version netinstall que je grave ensuite sur un CD grâce aux outils intégrés à
GNOME. Une fois que la gravure est terminée, les hostilités peuvent commencer
:

On boot sur le CD, chargement de l'interface. Au fil des écrans de
configuration, je choisis Français / France pour la linguistique, "homeNAS"
comme nom de machine et "WORKGROUP" comme domaine (pour le faire correspondre
avec celui des autres machines, c'est plus pratique).

Suit le formatage des disques :
Taille totale du disque dur : 61.5 Go

 1. 60.9 Go : format de fichier ext3, montée sur `/`
 2. 575.7 Mo : swap

En général, je met en taille de partition swap le double de la RAM de la
machine, plus du rab.

L'installateur se débrouille pour récupérer les paquets (installation par
Internet oblige) et les installe tranquillement. C'est le moment d'aller
chercher un café :) .

Enfin terminé, l'installateur me demande le mot de passe root. Réflexe :
[Strongpasswordgenerator](http://strongpasswordgenerator.com/).

Configuration du premier utilisateur non-root : j'ai pris comme nom :
"kizlum".

Le panneau suivant me demande le miroir de l'archive Debian : France
> ftp2.fr.debian.org.

L'installateur configure ensuite APT puis procède à plusieurs téléchargements
et installations. La aussi, on peut faire une pause.

Après toutes ces installations, il me demande si je veux ou non participer au
popularity-contest. Même si j'ai confiance en Debian, je n'y participe pas pour
des raisons que j'expliciterais dans un billet postérieur.

Il me demande ensuite quels logiciels installer : je décoche tout : je préfère
partir avec un système le plus propre possible. L'installateur télécharge et
installe ensuite les paquets correspondant à ce que vous avez choisis dans les
logiciels à installer. En dernier lieu, il installe et configure GRUB si vous
lui dites "oui" au panneau suivant. C'est ce que je m'empresse de faire.

L'installateur exécute quelques scripts de post-installation et éjecte le CD en
demandent de redémarrer : c'est partit.

L'ordinateur redémarre sans soucis, GRUB s'affiche et laisse la main au noyau,
qui se charge et me laisse enfin la main. Connexion en tant que root dans un
premier temps.

Dans un premier temps, je vérifie que tout est bien à jour :

~~~ bash
apt-get update
aptitude safe-upgrade
~~~

Voilà, l'intallation est terminée, je vais ensuite écrire un billet par
services à mettre en place.
