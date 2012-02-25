--- 
title: Installer Sphinx sous Ubuntu
---

Voila la petite astuce pour installer sans encombre
[Sphinx](http://sphinx.pocoo.org/) (le générateur de documentation Python) sous
Ubuntu. J'ai effectué cette manip' avec la version 9.04 du système.

Avant tout, il faut installer les dépendances (`python-dev`) et ce qui va nous
faciliter la vie (`python-setuptools`) :

~~~ bash
sudo apt-get install python-dev python-setuptools
~~~

Une fois que c'est terminé, vous pouvez ensuite utiliser l'outil `easy_install`
pour installer directement Sphinx :

`sudo easy_install -U Sphinx`
