--- 
title: "Déplacer des mails selon un critère donné dans une architecture Mailbox"
---

Aujourd'hui, j'ai décidé d'utiliser les services de [mon
hébergeur](http://www.alwaysdata.com/) afin de gérer mes mails.  Le switch se
passe bien, à un détail près : les
[newsgroups](http://fr.wikipedia.org/wiki/Newsgroup). Je suis abonné au groupe
[django-developers](http://groups.google.com/group/django-developers) des
[Google groups](http://groups.google.com/). Le problème, c'est que c'est
environ 15 mails de plus dans mon inbox tous les jours. Sur
[Gmail](http://mail.google.com/), j'utilisais un filtre. Pourquoi pas là ?

Me voila donc partit pour lire les bases de l'utilisation de [Script
Sieve](http://fr.wikipedia.org/wiki/Sieve/) afin de gérer côté serveur les
filtres. Après 3 minutes de recherche, voici le "script" :


~~~ text
if header :contains "Reply-To" "django-developers@googlegroups.com" {fileinto "Django-dev";}
~~~

Hop. Mais, quid des emails déjà reçus ? Tant qu'à les filtrer, autant tous les
ranger au même endroit. Et c'est après bien 20 / 25 minutes de recherche que me
voilà prêt avec un gentil petit script bash :


~~~ bash
#!/bin/bash

cd mail/kiznet.fr/thomas/cur/
FILES="*"

for f in $FILES
do
    result=$(cat $f | grep -i reply-to)
    if [[ $result =~ "django-developers@googlegroups.com" ]]; then
        echo "Processing $f file..."
        mv $f mail/kiznet.fr/thomas/.Django-dev/cur/
    fi

done
~~~

Et voilà. Le script regarde chaque fichier présent dans l'inbox. Il regarde si
il trouve  un champs `reply-to` ayant pour valeur
`django-developers@googlegroups.com` (marque de tous les mails venant du
groupe). Si il trouve, il déplace dans le dossier approprié (`Django-dev` chez
moi).

En espérant que ces petits scripts pourront être utiles à quelques uns.
Bonne journée.
