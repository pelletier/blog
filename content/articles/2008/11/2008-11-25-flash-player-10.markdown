--- 
wordpress_id: 54
title: Flash Player 10
wordpress_url: http://kiznet.fr/blog/2008/11/25/flash-player-10/
layout: post
---

Bonjours à tous. Je vais expliquer ici l'installation d'[Adobe Flash Player 10
release candidate](http://labs.adobe.com/technologies/flashplayer10/) (nom de
code : "Astro") sous Linux. Je ne présente pas le Flash Player, d'une part
parce qu'il est très probable que vous l'utilisiez, d'autre part parce qu'en
quelques secondes de Google, une explication qui me semble très claire vous
sera donnée. Ce n'est vraiment pas très compliqué, mais un ami m'a demandé il
y a peu comment faire, je tiens donc à en faire partager tout le monde.

Premièrement, pensez à désinstaller une éventuelle version précédente. Voilà
la marche à suivre par défaut sous Ubuntu : `sudo apt-get remove
flashplayer-nonfree` Ensuite, téléchargez le fichier .tar.gz du Flash Player :
[ici](http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_install_linux_081108.tar.gz).
Procédez à l'extraction : `tar zxvf flashplayer10_install_linux_081108.tar.gz
&& cd install_flash_player_10_linux`. Enfin, installez ! `sudo
./flashplayer-installer`

(lorsqu'il demande l'adresse où est votre navigateur, pour Ubuntu c'est par
défaut et pour la version actuelle : /usr/lib/firefox-3.0.0.1) Voilà !
Amusez-vous bien ! Si vous voulez creuser le sujet, je vous conseil de lire
les [releases
notes](http://labs.adobe.com/technologies/flashplayer10/releasenotes.html).
