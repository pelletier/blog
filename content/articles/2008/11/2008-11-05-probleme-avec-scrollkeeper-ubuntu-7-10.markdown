--- 
title: "Problème avec Scrollkeeper (Ubuntu 7.10)"
---

Si lors de vos installations utilisant aptitude vous obtenez des erreurs du
genre:

 > /var/lib/scrollkeeper/fr/scrollkeeper_extended_cl.xml:7250: parser error : Extra content at the end of the document

Voici un moyen pour vous en débarrasser:

~~~ bash
sudo mv /var/lib/scrollkeeper/fr/scrollkeeper_extended_cl.xml /root
sudo dpkg-reconfigure scrollkeeper
~~~

Attention à bien modifier la première commande suivant vos besoins (le nom du
fichier posant problème j'entends).
