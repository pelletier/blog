--- 
wordpress_id: 76
title: "Web s\xC3\xA9mantique : d\xC3\xA9couverte"
wordpress_url: http://kiznet.fr/blog/2008/11/05/web-smantique--dcouverte/
layout: post
---

## "Pourquoi ?"

Déjà, on va s'intéresser à la question "pourquoi ?". Non pas pourquoi le web
sémantique dans un premier temps, mais plutôt pourquoi je m'y intéresse. Cela
permettra d'aiguiller et de clarifier (je l'espère la réflexion). En fait, ça
fait un petit moment que ça me trotte dans la tête, j'ai une petite idée
d'application web centrée sur l'utilisateur. Je ne veux pas rentrer plus dans
les détails ici, je le ferais en temps voulu. Toujours est-il que je pense
qu'il est nécessaire de bien y implémenter les solutions de communications
sémantiques émergentes, d'un part car elles me semblent novatrices, plus de
services l'utiliseront plus elle sera connue et adoptée globalement.
Deuxièmement, parce que cette application brasserait beaucoup de données,
devrait toutes les rentres interopérable le mieux possible entre elles et avec
d'autres services. Voilà donc pourquoi je commence à m'y intéresser
sérieusement. Il n'y a donc ici que ce qui me semble être vrai. Si ça se
trouve, je me plante complètement.

## RDF<

La description des données. Je ne suis pas vraiment certain d'avoir compris.
En tout cas, il me semble que c'est un point primordial pour un projet. Bien
structurer ses données pour bien les décrire. Déjà en partant de là, si tout
est bien fait, l'interopérabilité peut-être très bonne entre les différentes
applications. Je ne vais pas plus m'étendre là dessus à cause de mon manque de
connaissances là dessus. Je pense que quand je maîtriserais mieux le sujet,
j'y dédirais un article.

## OpenID

Voilà un autre point clé. Même si l'application en question est centrée sur
l'utilisateur, il peut être très pratique qu'il puisse s'y connecter en
utilisant son identifiant OpenID, ce qui, selon moi, simplifie grandement les
choses. En plus de cela, une partie des informations nécessaire pour
identifier l'utilisateur sont probablement déjà écrite et il ne reste
quasiment plus rien à faire pour s'authentifier, si ce n'est taper une URL et
cliquer sur un bouton :) . Le fait qu'OpenID soit décentralisé est à mon goût
un avantage qui permet de faire un sorte que l'utilisateur fasse confiance
pour son mot de passe uniquement à son fournisseur, pas au service en lui
même.

## RSS / Atom

Chaque utilisateur produit de l'information. Ce même utilisateur peut-être
apprécié, ne serait-ce que par une seule personne. Cette dernière doit pouvoir
être au courant facilement des nouveauté et modifications publiées par
l'utilisateur. Il me semble donc que les flux de syndication comme RSS et Atom
sont parfaitement adaptés à cet usage si il sont correctement employés. Je
pense que l'utilisation combinée de RSS et RDF peut donne des résultats
vraiment satisfaisant. Néanmoins, je ne suis pas assez stable sur le sujet
pour le moment.

## Les autres

Il existe apparemment plein d'autres moyens d'obtenir une communication
normalisé et donc interopérable, je dois encore creuser, notamment du coté de
FOAF. Néanmoins, je me demande si la multiplication des moyens de
structuration des informations ne compliqueront pas, à l'avenir, plus les
choses que ce qu'elles les simplifient pour le moment.

## Django

Rapidement, à ce que j'en vois, Django est pas mal équipé et plusieurs projets
parallèles lui assure un support, quoi qu'émergeant, relativement complet en
ce qui concerne la sémantique. Encore une fois, c'est pour moi toujours très
flou et à tester. Mais il ne faut pas désespérer ;) .
