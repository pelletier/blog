---
title: Git-based Django deployment
layout: post
tags:
    - django
---

If you ever used [Heroku](http://www.heroku.com/) (or any similar service), you
may be jealous of their straightforward way to deploy new versions of
applications. At least, I am.

That's why I came up with a couple of hacks to mimic their
[git](http://git-scm.com/)-based deployment workflow, but for my own
[Django](http://www.djangoproject.com/) applications, served by
[Gunicorn](http://gunicorn.org/).

The basic idea is: your application code is contained in a Git repository, and
your production deployments are as simple as a `git push`.

*Note: because we will type commands on both the client and server side,
server-side commands will start by a `>` and client-side commands by a `$`. All
commands are executed by a regular user.*

## Table of contents

{:toc}

## Prepare your server

First of all, let's prepare the ground by installing all the software we need
on our production server (for the record, I used
a [Lucid](http://www.ubuntu.com/) [Vagrant box](http://vagrantup.com/)):

~~~ bash
> sudo apt-get install git-core
> sudo apt-get install python-virtualenv
> sudo apt-get install nginx
~~~

Now that we have the software, let's create the base structure for our
production website. In my configuration, I'm in my home, which is
`/home/vagrant/`.

~~~ bash
> mkdir www
> cd www
> virtualenv --no-site-package .
> mkdir var
~~~

The `var` directory will contain the pidfile and the gunicorn socket file. You
could also use it to store a [sqlite database](http://www.sqlite.org/) if you
are running a test server for example.


## Create your simple Django application

Switch to your desktop shell and create a basic Django application (I call it
`codebase`) along with a git repository:

~~~ bash
$ django-admin.py startproject codebase
$ cd codebase
$ git init .
~~~

We also add the Pip requirements file (because you use
[Pip](http://www.pip-installer.org/) to manage your module dependencies
right?): `$ echo "django\ngunicorn" > requirements.pip`.


### The deployment script

Now we have to create a simple bash script which will be executed right after
you push your new code to the server. I put it in the root of the project tree
because I think it's a good thing to versionize it with git. So open your
favorite text editor and write the `deploy.sh` script:

~~~ bash
#!/bin/sh

# Remember that this script will be executed by the unix user who push to the
# git repository ; and the script will be executed in ~/www/codebase/.

# Update requirements
../bin/pip install -r requirements.pip

# Reload the Gunicorn instance
kill -HUP `cat ../var/pid`

# Ideas of other things to do:
#   Apply South migrations?
#   Clear cache?
~~~

Now we add a first commit to our local repository:

~~~ bash
$ git add .
$ git commit -a -m "bare django project"
~~~

## Tweak your production git repository

First, clone your local repository into the `codebase` direcory:

~~~ bash
> git clone /vagrant/codebase /home/vagrant/www/codebase
~~~

*Note: /vagrant/ is a mount point to my desktop machine.*

In order to make git do the automatic things, we have to tweak its server-side
configuration. So add the following to the `> codebase/.git/config` file:

~~~ ini
[receive]
    denyCurrentBranch = "ignore"
~~~

It prevents Git from moaning about the fact that you push to a non-bare
repository.

We also have to create a [git
hook](http://www.kernel.org/pub/software/scm/git/docs/githooks.html) so as it
runs the `deploy.sh` script we wrote earlier. Write the following in the
`> codebase/.git/hooks/post-receive`:

~~~ bash
#!/bin/sh

# update the source tree
cd ..
env -i git reset --hard

# execute the deploy.sh script
sh deploy.sh
~~~

Don't forget to `> chmod +x codebase/.git/hooks/post-receive`.


## Unleash the green unicorn

In a normal production use, you should run Gunicorn using
[supervisord](http://supervisord.org/) or anything like it. But for this
example, I will run directly Gunicorn from the command line:

~~~ bash
> bin/gunicorn_django --pid var/pid --socket var/socket codebase/settings.py
~~~


## Add your changes to the production repository

Now you can easily push your changes to the production site. Just edit some
files, commit, and `git push ssh://yourserver/www/codebase/.git master` and
you're done. Requirements will be installed and Gunicorn will be gracefully
reloaded.


## Go further

The configuration is not done yet: we don't take care of settings! We obviously
need to swap development settings with production settings. You can use my
[Rails-like configuration for
Django](http://thomas.pelletier.im/2010/08/rails-like-configuration-style-for-django/)
to do this (it works flawlessly).
