--- 
title: "FreeBSD : serveur DNS Bind9"
---

*Je pars ici sur le fait que vous avez d'une part, les bases d'utilisation
d'une [FreeBSD](http://www.freebsd.org/fr/) (ou de n'importe quelle autre BSD,
voir distribution Linux) et d'autre part un système FreeBSD récent ([7
series](http://www.freebsd.org/releases/7.2R/announce.html) actuellement)
installé, fonctionnel et connecté à internet.*

Gardez en tête que je n'aborde ici que les aspects techniques de l'affaire, le
domaine des DNS étant un trop vaste sujet.

Je discerne deux utilisations d'un serveur de noms :

1. [Servir de cache pour le réseau local](#servir_de_cache_pour_le_rseau_local)
   : les postes utilisant le serveur verront leur vitesse de résolution de noms
   augmenter fortement (chez moi, je suis passé de 400ms à 6ms).
2. [Agir en maître d'un domaine](#agir_en_matre_dun_domaine) : cela vous
   permet, si vous possédez mondomaine.com, d'indiquer au monde que
   serveur.mondomaine.com réside à telle ou telle adresse IP, entre autres.

Bien sûr, il est possible de faire bien plus de choses avec Bind9, mais ça ne
m'intéresse pour le moment pas. Gardez aussi à l'esprit que je présente une
méthode pour atteindre les objectifs prévus. Il doit en exister pleins
d'autres. Si la mienne ne vous convient pas, et ben allez voir ailleurs !

## Installation de Bind9

En fait, cette section est plus faite pour faire beau qu'autre chose, car Bind9
(aussi connu sous le nom de *Named*) est installé par défaut sous FreeBSD. Pour
l'activer, rien de plus simple :

1. Ajoutez `named_enable="YES"` à `/etc/rc.conf`.
2. Démarrez le démon : `/etc/rc.d/named start`

Néanmoins, je tiens à préciser un point : par défaut, Bind9 n'écoute qu'en
local, c'est-à-dire que seule la machine sur laquelle il tourne peut y accéder.
Si vous voulez ouvrir votre serveur à l'extérieur (votre réseau local, mais
aussi le net), modifiez la ligne `listen-on { 192.168.0.16; };` dans
`/etc/namedb/named.conf`.  Où `192.168.0.16` est l'adresse IP sur le réseau
local de la machine en question.

## Servir de cache pour le réseau local

Bien. Tout se passe dans le fichier `/etc/namedb/named.conf`. Ouvrez le avec
votre éditeur favori et suivez le guide.

### Exploiter les serveurs DNS de votre FAI

Pour éviter que votre propre serveur DNS n'ai a attaquer directement les
serveurs DNS mondiaux (pour des raisons d'efficacité et d'encombrement de
réseau), vous devez donner à Bind9 l'IP du serveur DNS primaire **et**
secondaire de votre FAI. Dans mon exemple, c'est Numéricable, mais vous devriez
pouvoir trouver les infos concernant le votre [sur cette
page](http://www.commentcamarche.net/faq/sujet-1496-serveurs-dns-des-principaux-fai).

Recherchez, décommentez et complétez l'options `forwarders` comme ceci :

~~~ bash
forwarders {
 89.2.0.1;
 89.2.0.2;
};
~~~

### N'autoriser que votre réseau local

Si vous laissiez votre serveur DNS répondre à n'importe quelle machine, je
pense que ça ferait bien mal à votre serveur, votre bande passante, et votre
moral. C'est pourquoi nous allons définir une *Acess Control List*, que vous
allez adapter suivant votre configuration actuelle.

Ajoutez ce bloc avant le bloc `options` du fichier de configuration :

~~~ bash
acl localnet {
 127.0.0.1/32;
 192.168.0.1/24;
};
~~~

Ici, je dit qu'appartiendront au groupe `localnet` les ordinateurs ayant les
ips de type `127.0.0.*` et `192.168.0.*`, autrement dit : le serveur lui même
et les ordinateurs de mon réseau local.

### Les permissions

Le plus gros du travail est fait. Maintenant vous devez dire à Bind9 qu'il doit :

- Autoriser les requêtes venant de tous le monde (important pour la suite,
  voyez-ci après si vous ne voulez pas que ce soit le cas).
- N'autoriser uniquement les membres du groupe *localnet* crée plus tôt
  à demander de résoudre un nom dont le serveur n'est pas le maître (on appelle
  cela la *recursion*. C'est plus compliquer que ça, mais on va laisser la
  théorie de côté pour aujourd'hui).


Dans le bloc `options` du fichier de configuration, ajoutez les 3 lignes suivantes :

~~~ text
allow-query     { "any"; };
allow-transfer  { localnet; };
allow-recursion { localnet; };
~~~

Il est important que `allow-query` soit sur `any` si vous souhaitez agir en
tant que maître d'un domaine (voir ci-après). Si seul le cache vous intéresse,
n'accordez les requêtes que depuis `localnet` (pour éviter le flood) :
`allow-query { localnet; };`.

C'est tout ! Redémarrez Bind9 : `/etc/rc.d/named restart`, et admirez.

## Agir en maître d'un domaine

Pour l'exemple, je vais configurer un domaine local : `localnet`. Pour
information, si vous voulez gérer un domaine international (`mondomaine.com`
par exemple), c'est exactement la même chose !

Le but de mon domaine local est de fournir des adresses canoniques à certaines
de mes machines :

- server.localnet -> mon serveur perso : 192.168.0.16
- router.localnet -> le routeur de la maison : 192.168.0.1
- hdd.localnet -> le disque dur réseau : 192.168.0.14

Et c'est tout. Mais c'est quand même déjà sympathique.

*Je ne vais pas rentrer dans le détail de la configuration. Les fichiers
parlent d'eux-mêmes, et si vous les trouvez obscur, Google arrivera à vous
éclairer.*

Premièrement, créez et complétez le fichier */etc/namedb/localnet* :

~~~ text
$TTL    2h

@    IN    SOA    server.localnet. postmaster.localnet. (
                             2009101201
                             8H
                             2H
                             1W
                             1D
 )

@    IN    NS    server.localnet.

server        A    192.168.0.16
router        A    192.168.0.1
hdd           A    192.168.0.14
~~~

C'est ce fichier qui permet à Bind9 d'associer une adresse IP à un nom (on lui
donne le nom, il nous rend l'IP). Il faut aussi qu'il soit capable de faire
l'inverse : on lui donne une IP, il nous donne le nom. Le fichier qui s'en
occupe est relativement semblable.

Créez et complétez le fichier `/etc/namedb/localnet.reverse` :

~~~ text
$TTL 2h
@    IN    SOA    server.localnet. postmaster.localnet. (
                              2009101201
                              8H
                              2H
                              1W
                              1D
 )

@    IN    NS    server.localnet.

1     IN    PTR    router.localnet.
16    IN    PTR    server.localnet.
14    IN    PTR    hdd.localnet.
~~~

Notez que les nombres à gauche sont la dernière partie de l'adresse IP local de
la machine cible. Exemple de mon routeur : son IP est `192.168.0.1` le numéro
qui apparait en première place de sa ligne est donc 1.

Vous devez ensuite dire à Bind9 qu'il est le DNS maître du domaine `localnet`
et qu'il ne doit répondre pour ce domaine qu'aux requête du groupe `localnet`
(celui qu'on a crée plus haut).

Ajoutez à la fin du fichier `/etc/namedb/named.conf` :

~~~ text
zone "localnet" {
 type master;
 file "/etc/namedb/localnet";
 allow-query { localnet; };
};

zone "0.168.192.in-addr.arpa" {
 type master;
 file "/etc/namedb/localnet.reverse";
 allow-query { localnet; };
};
~~~

Vous devez faire attention ici dans le deuxième bloc : `0.168.192` est
l'inverse de `192.168.0`. Donc si vos IP de votre réseau local sont du genre
`192.168.1.*`, vous devrez indiquer la zone `1.168.192.in-addr.arpa`.

Redémarrez Bind9, et si votre ordinateur est configuré pour utiliser le serveur
en tant que serveur DNS, vous devriez pouvoir ping `router.localnet` (dans mon
exemple).

## Conclusion

Voilà, c'est tout. C'est pas bien compliqué quand on y pense. Bon courage avec
votre DNS !
