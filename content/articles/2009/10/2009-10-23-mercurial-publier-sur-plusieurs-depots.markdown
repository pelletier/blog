--- 
title: "Mercurial : Publier sur plusieurs d\xC3\xA9p\xC3\xB4ts"
---

## Le problème

Vous avez plusieurs dépôts Mercurial, en général un principal et un miroir
(pour la sauvegarde). Cependant, toujours garder les deux dépôts synchronisés
n'est pas toujours une mince affaire.

## Une solution

Ayant fait face au problème ci-dessus il y a peu, j'ai cherché une solution qui
pourrait le résoudre. Impossible cependant, de mettre la main sur quoi que ce
soit. J'ai donc décider d'écrire ma première extension pour Mercurial. Voici
[hg-publishall](http://bitbucket.org/pelletier/hg-publishall/). Une extension
simple qui rajoute une commande à l'outil `hg` : `pushall`. Lors de son
exécution, l'extension va lire le fichier `.hg/hgrc` du dépôt et y récupérer
tous les éléments dans `[paths]`, et pour chaque va effectuer un `hg push
<url_du_depot>`

### Installation

Récupérez la dernière version du script : [hg-publishall
(trunk)](http://bitbucket.org/pelletier/hg-publishall/get/tip.zip).
Décompressez l'archive et déplacez le script `publishall.py` là où vous placez
vos extensions Mercurial (chez moi c'est `/Users/thomas/Library/Mercurial/`).
Pensez à le rendre exécutable par le ou les utilisateurs qui vont utiliser le
script (`chmod +x publishall.py` sous Linux/BSD).

Vous devez ensuite configurer le dépôt qui va bénéficier de cette extension :

Soit le dépôt `~/depot-test/`, j'ouvre le fichier `~/depot-test/.hg/hgrc` et le
modifie comme suit :

~~~ ini
[paths]
default = ssh://server.localnet/depot-test/
bitbucket = https://:<user>:<pass>@bitbucket.org/<user>/depot-test/

[extensions]
publishall = /Users/thomas/Library/Mercurial/publishall.py
~~~

Votre dépôt est maintenant configuré pour utiliser l'extension hg-publishall;
et il sera publié sur deux autres dépôts : default (un dépôt sur le serveur du
réseau local) et bitbucket (notez au passage que l'authentification sur les
dépôts distant est exactement la même qu'ailleurs dans Mercurial).

### Utilisation

Rien de bien compliqué. Toujours dans `~/depot-test/`, après y avoir travaillé
un peu comme vous en avez l'habitude, il suffit de taper `$ hg pushall`.  Et
c'est parti, les modifications que vous avez effectué sur le dépôt vont être
publiées. Pour information : vous pouvez aussi utiliser `hg pusha`, qui est un
alias à `hg pushall`.

## Conclusion

Amusez vous bien, et n'hésitez pas à faire
remonter](http://bitbucket.org/pelletier/hg-publishall/issues/) tout ce que vous
pouvez !
