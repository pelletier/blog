--- 
wordpress_id: 9
title: Lightsearch
wordpress_url: http://kiznet.fr/blog/2009/05/10/lightsearch/
layout: post
---
<p>Bonjour. Il y a deux jours, j'ai trouvé que ce blog manque cruellement d'une
fonction de recherche. J'ai donc fait un rapide tour des applications de
recherche déjà existantes pour Django. J'en ai retenu trois :</p>

<blockquote>
<ul class="simple">
<li><a class="reference external" href="http://code.google.com/p/djangosearch/">djangosearch</a>, qui n'est malheureusement plus en développement.</li>
<li><a class="reference external" href="http://haystacksearch.org/">Haystack</a>, qui est une vraie machine à gaz à mon sens (et beaucoup trop lourd pour un simple blog).</li>

<li><a class="reference external" href="http://info.wsisiz.edu.pl/~blizinsk/simple-django-search.html">Divers snippets</a>, soit trop simplets, soit qui ne marche pas (compatibilité avec Django 1.x par exemple), bref : rien qui ne me va.</li>
</ul>
</blockquote>
<p>Une conclusion s'imposait : développer ma propre application de recherche. Je
vous présente donc <a class="reference external" href="http://bitbucket.org/Kizlum/django-lightsearch/">Lightsearch</a>.</p>

<p>Le but de cette application est de fournir un moyen simple d'effectuer des
recherches simples. Si vous cherchez de hautes performances et une liste de
fonctionnalités imposante, vous pouvez passer votre chemin. Ce n'est
absolument pas le but de cette application.</p>
<p>Si vous souhaitez jeter un oeil, approfondir le sujet ou filer un coup de
main, rendez-vous sur <a class="reference external" href="http://bitbucket.org/Kizlum/django-lightsearch/">la page BitBucket de Lightsearch</a>.</p>
<p>**EDIT:** voilà, la fonction de recherche est disponible sur Kiznet grâce à Lightsearch.</p>
