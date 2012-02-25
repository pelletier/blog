--- 
wordpress_id: 12
title: Installation de Debian Lenny (minimal)
wordpress_url: http://kiznet.fr/blog/2009/04/26/installation-de-debian-lenny-minimal/
layout: post
---

Pour des raisons de tests, je dois installer une Debian sur une machine virtuelle. Même si je l'ai souvent fait, je vais profiter de l'occasion pour l'expliquer ici, dans l'espoir que cela servira un jours à quelqu'un.

Nous allons donc voir comment installer une Debian Lenny (5.0). Même si je trouve le processus est relativement simple, il convient de ne pas se tromper.

L'installation est prévue pour faire de la machine un serveur et / ou une boîte à outils (utilisation du système comme ensemble de petits logiciels pour effectuer des tâches ponctuelles et spécifiques qu'il aurait été plus compliqué / long d'effectuer sur un autre système). Je vais procéder à cette installation sur une machine virtuelle, gérée par Parallels 4 (pour Mac). Notez bien que la procédure est pour ainsi dire la même que ce soit sur Parallels, VirtualBox, ou directement en dur.

![ISO Debian Lenny](http://kizlum.files.wordpress.com/2009/04/iso-debian.png)

## Étape 1 : se procurer Debian

Pour cela, pas 36 manières : direction [debian.org](http://debian.org/), section <a href="http://debian.org/distrib/">"Obtenir Debian"</a>. Parce que je suis pressé et que j'ai une bonne connexion internet, je vais choisir de <a href="http://debian.org/distrib/netinst">télécharger une petite image amorçable</a>. Pour information, ces images sont petites à télécharger (150 Mo environ), elles contiennent le minimum pour lancer l'installation système. L'installateur s'occupera ensuite de télécharger le nécessaire pour continuer. On les appele des images "netinstall". Il nous faut maintenant choisir notre architecture système. En général ce qui passe bien, c'est les <a href="http://cdimage.debian.org/debian-cd/5.0.1/i386/iso-cd/debian-501-i386-netinst.iso">i386</a>. Si vous vous lancez dans une installation en dur, vous pouvez choisir par exemple <a href="http://cdimage.debian.org/debian-cd/5.0.1/amd64/iso-cd/debian-501-amd64-netinst.iso">amd64</a> si vous disposez d'une machine à deux processeurs logiques (enfin, c'est plus compliqué que ça, mais passons).

## Étape 2 : création de la machine virtuelle

Commencez par lancer Parallels 4. Si l'assistant de création de nouvelle machine virtuelle ne se lance pas (ce qui est le cas lorsque vous avez déjà une machine virtuelle d'installée), cliquez avec le **bouton droit sur l'icône de Parallels dans votre dock**, puis choisissez **New** . Cela doit avoir pour effet de lancer l'assistant.

### Operating system detection

![Operating system detection](http://kizlum.files.wordpress.com/2009/04/operating-system-detection.png)

Cet écran vous demande où est votre CD qui va vous servir à installer le système d'exploitation, afin d'essayer de détecter le type d'OS que vous voulez installer. Dans notre cas, il s'agit d'une image CD. Sélectionnez donc **CD/DVD Image**, puis **Choose...** . Une petite fenêtre habituelle de Mac s'ouvre, vous devez alors selectionner l'image ISO que nous avons télécharger tout à l'heure.

Cliquez ensuite sur **Continue**.

### Detected system: Debian GNU/Linux

![Detected system](http://kizlum.files.wordpress.com/2009/04/detecte-system.png)

Le titre de l'écran vous indique que Parallels a bien détecté notre ISO comme
étant Debian GNU/Linux. Il vous propose un nom par défaut à la nouvelle
machine virtuelle : je n'ai pas d'imagination, j'ai choisis de ne pas le
changer.

Cliquez sur **Create**.

### Prepare to install Operating System

![Prepare to install](http://kizlum.files.wordpress.com/2009/04/prepare-to-install.png)

Rien à régler sur cet écran. Cliquez simplement sur **Done** pour passer à la
suite.

### Écran de la machine virtuelle

![Ecran de la VM](http://kizlum.files.wordpress.com/2009/04/ecran-mv.png)

Vous voici enfin devant l'écran de la machine virtuelle. Cliquez sur le bouton
** Start** en haut à gauche pour lancer la machine virtuelle et procéder à
l'installation de Debian.

## Étape 3 : installation de Debian

Bon, c'est partit pour rentrer dans le vif du sujet. Après lancement de la
machine virtuelle, vous voici devant le menu de boot de Debian :

![Ecran de boot Debian](http://kizlum.files.wordpress.com/2009/04/debian-boot.png)

Je ne vais pas entrer dans le détail de ce que fait chaque menu. Choisissez donc l'option par défaut : **Install**. Validez avez la touche **Entrée**.

Là, le système va se charger en mémoire. Cela peut prendre plus ou moins de temps, tout dépends de votre machine !

Une fois le chargement terminé, vous vous retrouvez devant un écran type de l'installateur de Debian. Sachez que la souris n'est pas disponible à ce moment là : les déplacements ne se font donc qu'avec les touches fléchées du clavier et la touche Entrée pour valider. Cependant, notez qu'en bas de l'écran se trouve une petite aide à la navigation (sous forme de texte en blanc).

Bien. Vous devez donc être devant l'écran de choix de langage :

![Choix de la langue](http://kizlum.files.wordpress.com/2009/04/debian-lang.png)

Pour ma part, je choisis le Français. Pour vous éviter de le chercher longtemps, tapez directement la **touche F**, qui vous amènera aux langues commençant par la lettre F.

Validez avec Entrée.

Vous voici devant le choix du pays où réside votre serveur :

![Choix localité](http://kizlum.files.wordpress.com/2009/04/debian-pays.png)

Ne soyez pas parano, ce paramètre est utilisé pour détecter quel serveur est le plus proche de vous pour vous aiguiller dans des choix que l'on va voir plus tard.

![Disposition du clavier](http://kizlum.files.wordpress.com/2009/04/debian-clavier.png)

Choisissez la disposition de votre clavier suivant vos besoins. Si vous avez un clavier Français AZERTY de base, laissez fr-latin9, il va très bien. Validez avec Entrée.

S'en suit diverses détections de matériel, téléchargement de modules etc... Vous n'avez pas votre mot à dire. Vient ensuite l'écran vous demandant le nom de votre machine (pour mieux la détecter sur le réseau) :

![Nom de la machine](http://kizlum.files.wordpress.com/2009/04/debian-nom.png)

Appuyez sur Entrée pour continuer.

Entrez ensuite le domaine réseau. Pour ma part, mon réseau local est largement peuplé de machine sous Windows, donc le nom de domaine est : WORKGROUP

![Domaine](http://kizlum.files.wordpress.com/2009/04/debian-domaine.png)

Appuyez sur la touche Entrée pour passer à la suite. Viens ensuite le partage de disque dur. En général, je choisis une configuration manuelle, car j'ai le plus souvent des besoins spécifiques. Pour le coup, je choisis le partionement automatique :

![Type de partion](http://kizlum.files.wordpress.com/2009/04/debian-part1.png)

Puis je choisis d'utiliser un disque entier :

![Choix du disque](http://kizlum.files.wordpress.com/2009/04/debian-part2.png)

Il faut ensuite choisir le disque à formater. Facile pour nous, il y en a qu'un :

![Bis](http://kizlum.files.wordpress.com/2009/04/debian-part3.png)

Pour des raisons de simplicité, je choisis de tout mettre dans une seule et même partition :

![Une partition](http://kizlum.files.wordpress.com/2009/04/debian-part4.png)

Récapitulation de la liste des changements à effectuer :

![Récapitulation](http://kizlum.files.wordpress.com/2009/04/debian-part5.png)

Demande de confirmation des changements :

![Confirmation](http://kizlum.files.wordpress.com/2009/04/debian-part6.png)

Le disque virtuel va donc être reformaté.

Vous devez ensuite entrer votre mot de passe root (administrateur) deux fois :

![Mot de passe root](http://kizlum.files.wordpress.com/2009/04/debian-pass.png)

Vous allez ensuite devoir configurer votre premier compte utilisateur par cette suite d'écran que je ne commenterais pas car ils sont explicite :

![Nom de l'utilisateur](http://kizlum.files.wordpress.com/2009/04/user-name.png)

![Nick utilisateur](http://kizlum.files.wordpress.com/2009/04/user-nick.png)

![Mot de passe utilisateur](http://kizlum.files.wordpress.com/2009/04/user-pass.png)

Une fois le nouveau compte utilisateur créé, vous devez ensuite définir le miroir APT a utiliser (c'est là que les informations de pays entrées plus tôt vont servir) à travers ces deux écrans :

![Choix du pays](http://kizlum.files.wordpress.com/2009/04/pays-mirroir-apt.png)

![Choix du miroir](http://kizlum.files.wordpress.com/2009/04/mirroir-apt.png)

Maintenant votre miroir est choisi. Vous devez ensuite entrer les informations supplémentaires nécessaire à la connexion, tel que le proxy :

![Proxy](http://kizlum.files.wordpress.com/2009/04/proxy.png)

J'ai laissé vide car je n'utilise pas de proxy.

Viens ensuite le popularity-contest. Ce programme a pour but de déterminé quels logiciels sont les plus utilisés pour les favoriser. Pour ma part, j'ai choisis non :

![Popularity contest](http://kizlum.files.wordpress.com/2009/04/pop-contest.png)

Après quelques téléchargements divers, l'installateur vous demande quels
logiciels installés, via une liste très sommaire. Mon but étant d'avoir une
machine la plus sobre possible pour ensuite y installer ce que je veux : je
décoche tout et je continue :

![Logiciels à installer](http://kizlum.files.wordpress.com/2009/04/screen-capture1.png)

Les logiciels demandés vont donc être téléchargés, installés et configurés
automatiquement.

GRUB est un logiciel permetant (entre autre) de lancer le noyau Linux. Il est
donc absolument nécessaire au fonctionnement du système. Répondez donc oui à
l'écran suivant :

![Installation de Grub](http://kizlum.files.wordpress.com/2009/04/screen-capture-1.png)

GRUB va donc être installé. Quelques petits paramétres système vont être configurés. Vous voici à la fin de l'installation.

![Fin de l'installation](http://kizlum.files.wordpress.com/2009/04/screen-capture-2.png)

Et voila. C'est finit. Appuyez sur Entrée et regardez votre machine virtuelle redémarrer. Vous voilà sous Debian !
