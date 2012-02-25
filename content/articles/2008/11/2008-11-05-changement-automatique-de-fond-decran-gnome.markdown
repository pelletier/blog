--- 
title: "Changement automatique de fond d'écran Gnome"
---

Voici un petit script que j'ai réalisé rapidement pour que mes fonds d'écran
Gnome tournent automatiquement. Vous pouvez le télécharger
[ici](http://devellinux.free.fr/pub/scripts/pygaw/pygaw.py). Une fois
téléchargé, placez le dans un dossier de votre choix (pour l'exemple, je vais
dire `/home/kizlum/Scripts/`). Vous devez ensuite le configurer. Ouvrez le
fichier pygaw.py téléchargé avec l'éditeur de texte de votre choix (**gedit**
par exemple). Cherchez maintenant dans le fichier deux lignes rassemblant à
ceci:

~~~ python
CHEMIN = "/home/user/images"
TEMPS = 10
~~~

Comme vous l'avez deviné, la ligne `CHEMIN=""` est une variable qui contient
l'adresse du dossier qui contient vos fonds d'écran. Si vous placez vos images
dans `/home/robert/Images/FondEcran`, alors éditez la ligne comme suit:

~~~ python
CHEMIN = "/home/robert/Images/FondEcran"
~~~

La ligne suivante : `TEMPS =` est la variable qui contient le temps qui doit
s'écouler entre chaque changement de fond d'écran. Ce temps est exprimé en
secondes. Pour un fond d'écran qui change toutes les 3 secondes, mettez
`TEMPS = 3`. Enregistrez votre fichier. Vous avez maintenant 2 possibilités :


1. Lancer manuellement le script: `python /la/ou/se/trouve/le/script/pygaw.py`
2. Demander gentiment à Gnome de le lancer au démarrage de la session. Pour se
faire, allez dans: **Système -> Préférences -> Sessions**, puis cliquez sur le
bouton **Ajouter**, dans le champ nom, mettez quelque chose qui vous évoque
quel script est lancé (exemple : "Script qui change le wallpaper" ou "PyGAW").
Dans commande, mettez la commande nécessaire pour lancer le script: `python
/la/ou/se/trouve/le/script/pygaw.py`. Cliquez ensuite sur **Valider** puis sur
**Fermer**.

Voila, le tour est joué ;) Dès que vous vous reconnecterez à votre session
Gnome, le fond se changera tout seul. Si vous découvrez des bugs ou problèmes
quels qu'ils soient avec ce script, merci de m'envoyer un mail.
