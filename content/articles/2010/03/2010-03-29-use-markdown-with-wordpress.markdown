--- 
title: "Use Markdown with Wordpress "
---

By default, Wordpress only allows you to write your posts in HTML (in the case
you have not noticed the built-in WYSIWYG editor creates and renders HTML).
However, there are many ways to mark up your texts on the web (HTML is not the
only one). My favorite is Markdown.

## The why

I think that using more document-oriented markup syntaxes has many benefits. For example :

 - Better separation between content and form, which undoubtedly leads to an
   improvement in interoperability and durability of your data.
 - Having fun with something different (but not really new).

## The how (with Wordpress)

*Before everything be sure to have the authorization to install new plugins on your Wordpress-powered web site.*

First, you need to render your markdown texts to HTML. This is where “Markdown
for WordPress and bbPress” comes. This plugin will use a PHP markdown parser to
render your text. As markdown accepts HTML, you don’t need to worry about your
old posts: they will be displayed as they always did.

And... that’s it! Don’t forget to take a look at the official [Markdown syntax
page](http://daringfireball.net/projects/markdown/syntax).

If you want a nicer way to type your posts (for example a real-time render of
your text), you could use my Wordpress plugin called [WP WMD
Admin](http://wordpress.org/extend/plugins/wmd-admin/). It will replace your
Wordpress text input by [WMD](http://wmd-editor.com/), the WYSIWYM Markdown
editor.

## The limits

Markdown is nice for blogs, or short descriptions. Although it’s not really in
the scope of this post, I think that Markdown misses some important markup
element. The firsts that come to my mind are:

 - ~~No table of content.~~ It looks like markdown supports the [TOC] command
   since 2.0
   ([source](http://www.freewisdom.org/projects/python-markdown/Table_of_Contents)).
 - No footnotes.
 - No color.
