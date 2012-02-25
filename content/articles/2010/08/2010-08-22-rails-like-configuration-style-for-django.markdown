--- 
wordpress_id: 652
title: Rails-like configuration style for Django
wordpress_url: http://thomas.pelletier.im/?p=652
layout: post
tags:
    - django
---

Django's default settings system is not very suitable for multiple
configuration profiles — development, testing, production and so on: you have
the settings.py, and that's it. As far as I'm concerned, my settings are
sometimes very different between my notebook and for instance my production
server. First of all, it is obviously out of the question to change the
settings.py on deployment. Some people append at the end of their `settings.py`
a simple `from deploy import *`, surrounded by a `try / except ImportError`
clause. In my opinion this workaround is neither sexy nor flexible. I finally
decided to use the Rails way to manage configuration in my latest pet project.

The principle is simple: replace the content of the settings.py by the one
provided further, create a config/ directory, as if it is an application, and
in this folder, put the default configuration in `__init__.py`, and add a Python
module per configuration profile. You should come up with something like that:

![Files tree](/assets/images/posts/tree1.png)

The default profile is 'development' (read the settings.py). If you want to use
a specific profile, prepend `DJANGO_ENV="theprofile"` to your shell command. It
must become very long to type this at each command, that's why I recommend you
to add this line to the 'bin/activate' script of the corresponding
[virtualenv](http://pypi.python.org/pypi/virtualenv), or in your
`~/.bash_profile`.


<script src="https://gist.github.com/543975.js"> </script>

