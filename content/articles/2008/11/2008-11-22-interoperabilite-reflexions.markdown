--- 
wordpress_id: 58
title: "Interop\xC3\xA9rabilit\xC3\xA9 : r\xC3\xA9flexions"
wordpress_url: http://kiznet.fr/blog/2008/11/22/interoprabilit--rflexions/
layout: post
---

## Le commencement

Je me suis intéressé à l'idée d'interopérabilité au commencement d'un projet
personnel ([dont je ne ferrais pas la
pub](http://pyggregator.googlecode.com)). En effet, j'utilisais la
bibliothèque GTK+ pour le rendu de l'interface utilisateur. Sous ma station de
développement (Linux / Gnome), tout allait bien, le monde était beau et les
oiseaux chantaient. Seulement, j'ai voulu voir comment il se comportait sous
Windows (un des but du projet étant la portabilité sans modification de la
source). Déjà, installation des dépendances, ce qui n'est pas vraiment simple
pour un néophyte, puis ça met relativement le bazar sur le disque dur. Qu'à
cela ne tienne, je pourrais faire un installateur pour les utilisateurs lambda
et ils n'y verront que du feu. Mal grès tout, le look des applications GTK
n'est pas du meilleur effet sur cette plateforme. Deuxième test, sous Mac OS
X. Là c'est carrément bien moins simple qu'avec Windows, même si je ne suis
pas un expert en Mac, c'est pas vraiment cool pour l'utilisateur. De plus, le
look est vraiment pas esthétique et il est quand même coûteux en mémoire de
lancer un serveur X11. C'est là que je me suis posé la question
d'interopérabilité.

## Un peu plus en détails

Pour pallier à cela, je n'ai pas vraiment de solution miracle pour le moment.
Java, vraiment trop lourd à mon goût, tant à coder qu'au niveau déploiement
(argument probablement de mauvaise fois, étant fan de Python ;-) ). Aucune
bibliothèque ne permet vraiment une bonne intégration au système. Je pense que
le problème est surtout là.

## Fainéant

En règle générale, je me classe dans la catégorie des flemmards, c'est
pourquoi, je n'ai pas envie de coder les mêmes unités graphiques sur 3-4
bibliothèques différentes pour avoir un bon rendu. Cependant, je veux vraiment
avoir un produit qui peut être exécuté sur n'importe quel environnement sans
modification du code source, ou même re-compilation. C'est assez idéologique,
mais je suis persuadé que c'est possible. Pour moi, ce genre de finalité se
base sur la connaissance des interfaces des deux systèmes, pour un rendu
homogène quelque soit ses conditions d'utilisation.

## Mot de la fin

En fait, cet article n'est pas très long, car je me suis rendu compte que les
informations que je pensais stables dans mon l'esprit ne sont en fait que très
fragiles et floues. C'est pourquoi je ne vais pas pas plus m'étendre sur le
sujet. Mais l'idée d'une bibliothèque pour les principales d'interfaces ne me
déplais pas, mais alors pas du tout !