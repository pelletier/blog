--- 
wordpress_id: 74
title: Les alias Bash
wordpress_url: http://kiznet.fr/blog/2008/11/05/les-alias-bash/
layout: post
---

Les alias avec Bash, voila une méthode pratique ! Cette méthode permet de
substituer une commande par une autre. Par exemple, si comme moi, vous avez
horreur d'utiliser `ls` sans arguments, au lieu de taper `ls -ali` à chaque
fois, vous pouvez définir un alias et remplacer `ls` par `ls -ali`. Voici
comment nous procédons: Lancez une console et tapez, pour notre exemple:
`alias ls='ls -ali'` dans la même console, testez `ls`, normalement c'est bon
;) Pour garder cet alias et l'appliquer à toutes les instances de bash,
rajoutez la ligne que vous venez d'entrer pour définir l'alias dans le fichier
**~/.bashrc**. Et voila :)
