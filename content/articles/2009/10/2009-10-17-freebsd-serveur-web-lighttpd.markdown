--- 
title: "FreeBSD : serveur web Lighttpd"
---

*Je pars ici sur le fait que vous avez d'une part, les bases d'utilisation
d'une [FreeBSD](http://www.freebsd.org/fr/) (ou de n'importe quelle autre BSD,
voir distribution Linux) et d'autre part un système FreeBSD récent ([7
series](http://www.freebsd.org/releases/7.2R/announce.html) actuellement)
installé, fonctionnel et connecté à internet.*

## Servir pour le web

Pour cela, vous devez déterminer quel serveur web remplira cette tache pour
vous. Chacun ses choix, chacun ses arguments. Je choisi ici d'installer
[Lighttpd](http://www.lighttpd.net/) (a.k.a. Lighty), car il convient
parfaitement à mes besoins et est simple pour une utilisation standard.

Je couvrirais ici son installation et sa configuration pour l'utilisation suivante :

 - [Lighty](#lighty) (avec support FastCGI)
 - [PHP5](#php5)
 - [Django](#django) (Python 2.6)
 - [Mercurial](#mercurial)

Rien de bien sorcier, le tout étant d'être méthodique et de prévoir dès le
départ où on veut aller.

## Lighty

Rien de bien compliquer dans l'installation de Lighty par les *ports* :

~~~ bash
$ cd /usr/ports/www/lighttpd
# make install clean
~~~

Normalement, les options de compilation pour Lighty doivent vous être
demandées. Voici celles que j'ai choisi :

![Options de compilation Lighty](/assets/images/posts/lighty-options-300x228.png)

Normalement, l'installation devrait se dérouler sans trop de problème. Ajoutez
maintenant la ligne suivante à `/etc/rc.conf` :

~~~ bash
lighttpd_enable="YES"
~~~

Rien d'autre à faire ici. Pour votre information, le fichier de configuration
est placé suivant la norme FreeBSD : `/usr/local/etc/lighttpd.conf`. Pour
lancer/arrêter/redémarrer le serveur, utilisez `/usr/local/etc/rc.d/lighttpd
start|stop|restart`. Pour récupérer des infos en cas de soucis, c'est `tail -f
/var/log/lighttpd.error.log`.

## PHP5

Là aussi, on va utiliser les ports :

~~~ bash
$ cd /usr/ports/lang/php5
# make install clean
~~~

Rien de très palpitant ici. Il nous faut maintenant installer les extensions
PHP voulues, toujours par les ports :

~~~ bash
$ cd /usr/ports/lang/php5-extensions
# make install clean
~~~

Lors de la configuration, la liste des extensions à installer devrait vous
êtres demandée. Choisissez celles que vous voulez. Pour info, j'ai choisis
celles-ci : ctype, curl, dom, gd, imap, mbstring, mcrypt, mysql, mysqli, pcre,
posix, session, simplexml, xml, xmlreader, xmlrwriter, zlib.

A la fin de l'installation, ouvrez le fichier de configuration de Lighty et
effectuez les modifications suivantes :

 - Dans la liste `server.modules`, dé-commentez `mod_fastcgi`.
 - Descendez et dé-commentez le bloc relatif à fastcgi.server :

~~~ lighty
fastcgi.server = ( ".php" =>
                         ( "localhost" =>
                              (
                               "socket" => "/tmp/php-fastcgi.socket",
                               "bin-path" => "/usr/local/bin/php-cgi"
                              )
                         )
)
~~~

Enregistrez et relancer Lighty. PHP est maintenant opérationnel (vous pouvez
tester avec un `<?php phpinfo(); ?>`).

## Django

C'est ici la partie qui m'intéresse le plus.

Premièrement, installez Django (notez que ceci n'est qu'une façon de faire) :

~~~ bash
$ cd /usr/ports/devel/py-setuptools
# make install clean
# /usr/local/bin/easy_install django
~~~

OK. Bon, dans mon cas, j'ai une application située dans `/storage/www/thomas/`,
qui sera accessible depuis le web par http://thomas.pelletier.im/. Adaptez
suivant vos besoins.

 1. Créez un dossier public dans `/storage/www/thomas/`.
 2. Adaptez et placez-y le fichier `lighty.sh` suivant :
~~~ bash
#!/bin/sh
app_path='/storage/www/thomas/'
p='/tmp/thomas-django.pid'
cd "$app_path"
if [ -f $p ]; then
 kill $(cat -- $p)
 rm -f -- $p
fi

exec /usr/bin/env \
 PYTHONPATH="$app_path/.." python \
 manage.py runfcgi \
 daemonize=false \
 method=prefork \
 maxspare=2 \
 pidfile="$p"
~~~
 3. Rendez le exécutable par www :
~~~ bash
$ chown www:www lighty.sh
$ chmod +x lighty.sh
~~~
 4. Créez un fichier vide `django.fcgi` dans `public/` (pas nécessaire je
    pense, mais ça marche pour moi).
 5. Ajoutez le bloc suivant à votre `ligtttpd.conf` :
~~~ lighty
$HTTP["host"] == "thomas.pelletier.im" {
        server.document-root = "/storage/www/thomas"

        url.rewrite-once = (
                "^(/.*)$" => "/public/django.fcgi$1",
        )                    

        fastcgi.server = (
                ".fcgi" => (
                        "django" => (
                                "socket" =&gt; "/tmp/thomas-django.socket",
                                "bin-path" =&gt; "/storage/www/thomas/public/lighty.sh",
                                "check-local" =&gt; "disable"
                        )
                )
        )

}
~~~
 6. Enregistrez et relancer Lighty.

Normalement c'est bon, votre projet Django est maintenant servi par lighty !

## Mercurial

*NB : je ne vais pas entrer dans les détails de la configuration d'un dépôt
mercurial.*

Il existe plusieurs moyens de servir des dépôts mercurial. J'ai choisis
[hgwebdir](http://mercurial.selenic.com/wiki/HgWebDirStepByStep). Le site
officiel détail l'installation en CGI. Je trouve ça dommage. Pour ma part,
j'utilise ici FastCGI.

*Je pars du fait que vous avez vos dépôts déjà configurés et fonctionnels dans
`/mesdepots/` et que vous avez deux dépôts : un publique : `helloworld` et
l'autre privé `myproject`.*

Pour la petite histoire, `helloworld` sera accessible en lecture **ET**
écriture par **tout le monde**. C'est fait exprès, à but purement pédagogique.
`myproject` lui, n'est accessible en écriture **et** en lecture uniquement par
vous.

Premièrement, créez un dossier `hg` dans `/mesdepots/`. Placez-y le fichier
`hgwebdir.fcgi` suivant :

~~~ python
#!/usr/bin/env python
#
# An example CGI script to export multiple hgweb repos, edit as necessary

# adjust python path if not a system-wide install:
#import sys
#sys.path.insert(0, "/path/to/python/lib")

# enable demandloading to reduce startup time
from mercurial import demandimport; demandimport.enable()

# Uncomment to send python tracebacks to the browser if an error occurs:
#import cgitb
#cgitb.enable()

# If you'd like to serve pages with UTF-8 instead of your default
# locale charset, you can do so by uncommenting the following lines.
# Note that this will cause your .hgrc files to be interpreted in
# UTF-8 and all your repo files to be displayed using UTF-8.
#
#import os
#os.environ["HGENCODING"] = "UTF-8"

from mercurial.hgweb.hgwebdir_mod import hgwebdir
from flup.server.fcgi import WSGIServer

# The config file looks like this.  You can have paths to individual
# repos, collections of repos in a directory tree, or both.
#
# [paths]
# virtual/path1 = /real/path1
# virtual/path2 = /real/path2
# virtual/root = /real/root/*
# / = /real/root2/*
#
# [collections]
# /prefix/to/strip/off = /root/of/tree/full/of/repos
#
# paths example:
#
# * First two lines mount one repository into one virtual path, like
# '/real/path1' into 'virtual/path1'.
#
# * The third entry tells every mercurial repository found in
# '/real/root', recursively, should be mounted in 'virtual/root'. This
# format is preferred over the [collections] one, using absolute paths
# as configuration keys is not supported on every platform (including
# Windows).
#
# * The last entry is a special case mounting all repositories in
# '/real/root2' in the root of the virtual directory.
#
# collections example: say directory tree /foo contains repos /foo/bar,
# /foo/quux/baz.  Give this config section:
#   [collections]
#   /foo = /foo
# Then repos will list as bar and quux/baz.
#
# Alternatively you can pass a list of ('virtual/path', '/real/path') tuples
# or use a dictionary with entries like 'virtual/path': '/real/path'

WSGIServer(hgwebdir('hgweb.config')).run()
~~~

Toujours dans le même dossier, créez et complétez le fichier `hgweb.config`
suivant :

~~~ ini
[paths]
helloworld = /mesdepots/helloworld/
myproject = /mesdepots/myproject/

[extensions]
hgext.highlight=

[web]
style = monoblue
allow_archive = bz2 gz zip
baseurl = /hg/
pygments_style =
~~~

Dans le fichier `.hg/hgrc` de `myproject`, ajoutez les paramètres suivant dans le bloc `[web]` :

~~~ ini
allow_push = monutilisateur
allow_read = monutilisateur
~~~

Vous allez maintenant devoir créer le fichier contenant les comptes virtuels
(ie : les utilisateurs mercurial ne sont pas des utilisateurs système). Créez
le fichier `/mesdepots/hg/passwords` et ajoutez une ligne par utilisateur (vous
pouvez [utiliser des outils en
ligne](http://www.htaccesstools.com/htpasswd-generator/) pour générer les
lignes à rajouter). Pensez que dans l'exemple, le nom d'utilisateur est
`monutilisateur`.

Editez le fichier `/usr/local/etc/lighttpd.conf` en l'adaptant à vos besoin,
ici, les dépôts sont accessibles depuis http://monsite.com/hg/.

~~~ lighty
$HTTP["host"] == "monsite.com" {
    server.document-root = "/mesdepots/"
    server.follow-symlink = "enable"
    fastcgi.debug = 1

    url.rewrite-once = (
        "^/hg(.*)" => "/hg/hgwebdir.fcgi$1",
    )

    $HTTP["url"] =~ "^/hg/" {
        dir-listing.activate = "enable" 

        # My Private repositories
        auth.debug = 2
        auth.backend = "htpasswd"
        auth.backend.htpasswd.userfile = "/mesdepots/hg/passwords"
        $HTTP["url"] =~ "myproject/" {
            auth.require = ( "" => (
                    "method" => "basic",
                    "realm" => "This is a private repository. If not allowed, go fuck yourself.",
                    "require" => "valid-user"
                )
            )
        }

        # Global config

        fastcgi.server = (
            ".fcgi" => (
                "hgwebdir" => (
                    "bin-path" => "/mesdepots/hg/hgwebdir.fcgi",
                    "socket" => "/tmp/hg.socket",
                    "check-local" => "disable",
                )
            )
        )
    }

}
~~~

Définissez l'utilisateur et le groupe *www* comme propriétaire du dossier
`/mesdepots/hg` (`chown -R www:www /mesdepots/hg`). Donnez enfin les droits
d'exécution à `hgwebdir.fcgi` (`chmod +x /mesdepots/hg/hgwebdir.fcgi`) et
redémarrez votre lighty.
