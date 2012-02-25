--- 
title: Avant Window
---

Après avoir testé plusieurs Docks comme [Kibadock](http://www.kiba-dock.org/),
ma préférence est allée à [Avant Window Navigator](http://awn-project.org/)
(AWN).

Voici une méthode pour l''installer (la version en cours de dev) :


 1. Installer les dépendances (sous Ubuntu):

~~~ bash
sudo apt-get install bzr libgtk2.0-dev libwnck-dev libwnck-common libgconf2-dev libglib2.0-dev gnome-common libgnome-desktop-dev libdbus-glib-1-dev libxcomposite-dev libxdamage-dev python-gtk2-dev python-cairo-dev python-gnome2-dev python-gnome2-desktop-dev python-gnome2-extras-dev libgnome-menu-dev librsvg2-dev libgtop2-dev gtk-doc-tools libsexy-dev libnotify-dev libvte-dev python-alsaaudio python-feedparser python-xdg
~~~
 2. Télécharger les sources :

~~~ bash
bzr co http://bazaar.launchpad.net/~awn-core/awn/trunk avant-window-navigator
bzr co http://bazaar.launchpad.net/~awn-extras/awn-extras/trunk awn-extras
~~~
 3. Allez dans le dossier avant-window-navigator et compilez :

~~~ bash
cd avant-window-navigator && ./autogen.sh && make && sudo make install
~~~
 4. Pour installer les plugins, retournez dans le dossier précédent, et répétez la même opération dans le dossier awn-plugins: 

~~~ bash
cd awn-plugins && ./autogen.sh && make && sudo make install
~~~
