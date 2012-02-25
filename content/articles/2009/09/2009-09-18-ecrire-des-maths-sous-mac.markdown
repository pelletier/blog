--- 
wordpress_id: 332
title: "\xC3\x89crire des maths sous Mac"
wordpress_url: http://kiznet.fr/?p=332
layout: post
---

Il y a quelques jours, j'ai du trouver un moyen d'écrire du texte mathématique
avec mon Mac. Après plusieurs recherches et essais, voici la solution que j'ai
choisie, basée sur la [suite iWork '09](http://www.apple.com/fr/iwork/)
d'Apple.

- [Pages](http://www.apple.com/fr/iwork/pages/), de la suite iWork '09 comme
  traitement de texte.
- [Numbers](http://www.apple.com/fr/iwork/numbers/), aussi de la suite iWork
  '09 comme tableur.
- [MathType 6](http://www.dessci.com/en/products/mathtype/), pour écrire le
  texte purement mathématique.
- [Geogebra](http://www.geogebra.org/cms/index.php?lang=fr), pour la géométrie
  et tout ce qui touche à de la représentation graphique (ou presque).

## Le prix

J'avoue que le premier problème dans cette solution est le prix : 80€ pour
iWork + 65€ pour MathType = 145€. Après, c'est à vous du juger si vous devez
vraiment investir autant. Cependant, iWork '09 et MathType 6 existent tous deux
en version d'essai 30 jours, ce qui est largement suffisant il me semble pour
se forger un bon avis sur ces deux produits :

- [Télécharger iWork '09 version d'essai 30 jours](http://www.apple.com/fr/iwork/download-trial/)
- [Télécharger MathType 6 version d'essai 30 jours](http://www.dessci.com/en/products/mathtype/trial.asp?src=linkBox)

Geogebra est gratuit (et même open-source), ce n'est donc pas un problème.

## Le côté technique

Je n'ai pas de remarques concernant iWork. Cependant : MathType a besoin de
[Rosetta](http://www.apple.com/fr/rosetta/) pour tourner. Ce n'est pas un drame
en soit, mais ça surprend toujours (je n'avais encore jamais croisé une
application qui en avait besoin. Il y a un début à tout).

Geogebra utilise Java. Rien de grave non plus, mais il faut juste s'y faire.

## En pratique

Dans un premier temps, vous devez installer iWork et MathType (normalement,
Java est déjà installé). Je ne vais pas m'étendre là dessus, le processus étant
assez trivial; pensez tout de même à installer iWork **avant** MathType, pour
éviter quelques soucis par la suite.

Pour insérer une formule dans Pages, vous devez aller dans le menu
**Insertion** puis **Équation MathType**. Pages ouvre MathType, tapez votre
formule (je vous laisse découvrir le logiciel lui même), fermez la fenêtre de
MathType (⌘+W), et votre équation doit apparaître dans votre page Pages.

Voila. Vous m'accorderez que cette méthode est relativement peu pratique,
longue et fastidieuse. Nous allons donc établir un raccourci clavier pour
appeler directement MathType depuis Pages.

*Note : La méthode d'attribution de raccourcis claviers décrite ci-après est la
même quelque soit l'application Mac.*

1. Ouvrez le panneau de préférences (menu  puis Préférences Système), puis
   allez dans la rubrique **Clavier**.
2. Une fois dans Clavier, allez dans l'onglet **Raccourcis Clavier**, puis dans
   la liste de gauche, sélectionnez **Raccourcis d'Applications**.
3. Là, clickez sur le bouton **+** au milieu de la fenêtre. Une boîte de
   dialogue s'ouvre. Dans la liste déroulante **Application**, choisissez
   "Autre", puis naviguez jusqu'à Pages (dossier **Applications** puis **iWork
   '09** et enfin **Pages**). Dans le champs de texte **Titre du menu**, vous
   devez écrire **exactement** "Équation MathType" (je vous recommande de faire
   un copier / coller). Enfin, dans le champs **Raccourci clavier**, entrez
   celui qui vous préférez. Pour moi c'est ⌘⇧E.

Fermez Pages (si il est ouvert) et ouvrez le. Allez dans le menu **Insertion**,
et vous devrez normalement voir votre raccourci à côté d'"Équation MathType".

## Pour finir

Ce n'était pas bien dur, avouez-le. Maintenant, il ne vous reste plus qu'à
apprendre les raccourcis claviers de MathType, ce qui permet de gagner un temps
fou au cours de la frappe.

