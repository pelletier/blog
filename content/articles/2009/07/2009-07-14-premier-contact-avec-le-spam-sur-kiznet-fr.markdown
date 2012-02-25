--- 
wordpress_id: 4
title: Premier contact avec le spam sur kiznet.fr
wordpress_url: http://kiznet.fr/blog/2009/07/14/premier-contact-avec-le-spam-sur-kiznetfr/
layout: post
---
<p>Jusqu'à maintenant, je n'avais jamais eu de soucis avec le spam sur kiznet.fr, et je ne m'en plaignait pas.
Et là, il y a trois jours, tout à commencé : environ 1 000 spams en commentaires par jour.
J'ai d'abord mit en place <a class="reference external" href="http://sciyoshi.com/blog/2008/aug/27/using-akismet-djangos-new-comments-framework/">Akismet pour Django</a> (avec quelques bidouilles). Le spam est passé de 1 100 à 900. Moins pire, mais c'est pas la joie.
J'ai alors fait ce que je m'étais juré de ne jamais faire (et j'ai encore mal, je vous l'assure) : j'ai mit en place un <a class="reference external" href="http://fr.wikipedia.org/wiki/Captcha">captcha</a> (en l'occurrence, <a class="reference external" href="http://recaptcha.net/">reCAPTCHA</a>). J'ai honte, mais au moins, ça fait moins mal.
Outre le défi psychologique personnel qu'à représenté la mise en place du captcha, je me suis heurté aussi à un soucis technique : tous les snippets que j'ai trouvé concernant reCAPTCHA n'ont servi à rien ! Ils sont tous soit incomplet (tout le code n'est pas fournit) soit dépassé (<a class="reference external" href="http://www.djangoproject.com/">Django</a> évolue). J'ai donc mit la main à la pâte et j'ai codé ma propre application (d'une manière pas très élégante, mais pour se point précis, je trouve que Django n'offre pas une assez grande souplesse. A l'occasion, j'essayerais de voir si je ne peux pas écrire un patch), que je rendrais disponible sur <a class="reference external" href="http://bitbucket.org/Kizlum/">mon bitbucket</a>.</p>

<p>Au passage, le  site n'a pas été disponible aujourd'hui de 18h40 à 18h45 : petit soucis de la part d'Alwaysdata, mais qui, heureusement et comme toujours, ont maîtrisé la situation.</p>
