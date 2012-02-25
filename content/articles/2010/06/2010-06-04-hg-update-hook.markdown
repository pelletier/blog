--- 
title: Hg update hook
---

Note for myself : add the following to the .hg/hgrc file to automatically
update the repo when a changeset is pushed:

~~~ ini
[hooks]
incoming = hg up
~~~
