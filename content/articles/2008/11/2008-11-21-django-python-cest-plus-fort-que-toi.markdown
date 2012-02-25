--- 
wordpress_id: 62
title: "Django : Python, c'est plus fort que toi !"
wordpress_url: http://kiznet.fr/blog/2008/11/21/django--python-cest-plus-fort-que-toi/
layout: post
---
Aujourd'hui''hui, je vais vous présenter <a href="http://www.djangoproject.com/">Django</a>, "Le framework web pour les perfectionnistes sous pression" ! Avouez que c''est déjà pas mal comme slogan.
Je vais parler ici de mon expérience personnelle d'amateur qui pratique l''informatique sur son temps libre. Donc tout ce que je peux raconter ici peut apparaître totalement FAUX à un expert en la matière, mais bon, faut bien se lancer un jour hein :) .
<h2>Les fondations</h2>
Comment creuser la base, ou la mise en place du framework dans un environnement <a href="http://fr.wikipedia.org/wiki/Linux">Linux</a> / <a href="http://httpd.apache.org/">Apache 2</a> / <a href="http://www-fr.mysql.com/">Mysql 5</a>.

Pour ma part, je réalise tout mes essais sur mon serveur (enfin, c'est plutôt ronflant comme nom, il ne s'agit que d''un Pentium 2 avec 18Go de disque dur qui fait un bruit d''enfer hein) qui tourne sous <a href="http://www.debian.org/index.fr.html">Debian</a> (<a href="http://www.debian.org/releases/testing/">Lenny</a>). Pour l''installation, il m'a suffit d'installer le module Python pour Apache (facilement grâce à Aptitude). J'ai ensuite installé Django en lui même (ce qui se résume à télécharger la version en cours de développement puis créer 2-3 liens symboliques, du gâteau quoi), puis paramétrer mon httpd.conf (de même, processus très simple grâce à la <a href="http://www.django-fr.org/documentation/install/">très bonne documentation</a> très bien traduite par <a href="http://www.biologeek.com">David Larlet</a>. Résultat, en partant de rien, un framework fonctionnel disponible en production en tout juste 5 petites minutes.

<h2>Le commencement</h2>
Où on s'assoit bien droit correctement sur sa chaise, qu'on retrousse ses manches, réajuste ses lunettes, ferme toutes les applications autres que le navigateur, et qu'on ferme la porte du bureau.

J'ai encore été agréablement surpris : la documentation est abondante. D'une part, la doc' du <a href="http://www.djangoproject.com/documentation/">site officiel</a> qui couvre un très grosse partie et qui permet de bien dégrossir le travail. Ensuite, cette même documentation (et un peu plus) traduite sur <a href="http://www.django-fr.org/documentation/">Django-fr</a>. Finalement, je suis tombé sur <a href="http://www.djangobook.com/en/1.0/">The Django Book</a> (aussi disponible en <a href="http://www.amazon.com/Definitive-Guide-Django-Development-Right/dp/1590597257">livre papier</a>). De toute façon, la communauté est loin d'être minime, et <a href="http://www.google.com">Google</a> is your (only?) friend, donc pas de quoi s'inquiéter.

Au bout d''une quarantaine de minutes, on réalise une application de votes fonctionnelle (sobre, mais efficace), le tout avec très peu de code et le moteur proprement séparé de l'affichage. Que du bonheur !

<h2>Oui mais non !</h2>
*"Un cri retentit dans la salle de bains..." (Tribulations, Chapitre 2, Verset XVI)*
Que du bonheur mais ... sans compter un petit problème (que je n''ai pas réussit à résoudre, mais je cherche encore !) : la gestion des accents et de l'<a href="http://fr.wikipedia.org/wiki/UTF-8">UTF-8</a> dans l''interface d''administration auto générée. En effet, Django vous génère une interface permettant l''administration de la base de donnée suivant les modèles que vous avez définit dans votre application, le tout de manière sobre et fonctionnelle. Pour ma part, un problème intervient au moment où je veux utiliser des accents dans du texte, là, il aime pas ! Mais je pense que le problème vient de moi de toute façon.
<h2>Au final</h2>
Pour le moment, je ne dispose pas encore d''assez d''éléments pour juger et émettre un point de vue plus approfondit sur Django, mais pour l'instant, voici mon bilan : Un gain de temps inimaginable : très peu de code, si les modèles de données sont bien pensés dès le départ, tout va tout seul. Des templates pratiques : Ils permettent d''étendre d'autres templates, de pouvoir émettre des valeurs par défaut et remplaçables avec des systèmes de blocs. Propreté : Le code généré est très propre, ainsi que la séparation entre les structures et l'interface. Seul point négatif pour le moment : ce problème d'accents.

**Le mot de la fin :** Je vais bientôt prendre un hébergement <a href="http://www.ovh.com/fr/particulier/produits/60gp.xml">60GP</a> chez <a href="http://www.ovh.com">OVH</a>. Mon but sera d''y développer mon espace perso (un blog surtout), en utilisant uniquement Django. Je vais tenir au courant de comment tout cela se passe.
