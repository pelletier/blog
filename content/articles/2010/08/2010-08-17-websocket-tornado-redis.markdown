--- 
wordpress_id: 630
title: Websocket + Tornado + Redis
wordpress_url: http://thomas.pelletier.im/?p=630
layout: post
---
Here is a simple example of a [Websocket](http://en.wikipedia.org/wiki/WebSockets) + [Tornado](http://www.tornadoweb.org/) + [Redis](http://code.google.com/p/redis/) [Pub/Sub protocol](http://code.google.com/p/redis/wiki/PublishSubscribe)  interaction. The principle is very simple: when your user loads the page, she is automatically added to a list of "listeners". An independent thread is running: it listens for messages from Redis with the [subscribe](http://code.google.com/p/redis/wiki/PublishSubscribe#SUBSCRIBE_channel_1_channel_2_..._channel_N) command, and send a message through Websocket to every registered "listener". In this example, the user can send a message to herself with a simple AJAX-powered form, which calls a view with a payload (the message), and the view publish it via the [publish](http://code.google.com/p/redis/wiki/PublishSubscribe#PUBLISH_channel_message) command of Redis.

This is basically a web chat! If you want to have fun, you can then add a roster, with a presence system, authentication etc...

<script src="http://gist.github.com/532067.js"> </script>
