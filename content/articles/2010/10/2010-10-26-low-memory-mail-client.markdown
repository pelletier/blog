--- 
title: Low-memory mail client
edited: 07/08/2011
---

I have a MacBookPro which has 2GB of RAM and I always have many applications
launched, so the whole memory is almost always fully used. Therefore I try to
find new ways to use the smallest amount of memory. Today, I fought with
mails. I love mails, so I can't get rid of them, and I love them so much that
I must be able to read and compose e-mails even when I don't have an Internet
access (this feature has already saved my life, many times).

[Mail.app](http://goo.gl/wp9A5), the Apple's built-in mail client is correct
(ie, I don't want to punch my computer screen each time I have to deal with
it), but has a very large memory footprint: more or less 70MB of RAM. Not
sustainable in my case.
[Google's Gmail](http://gmail.com/) is great, but it does not allow me to read
and write e-mails offline on MacOS X, so it is a dead end.
Finally, [Thunderbird](http://www.mozillamessaging.com/en-US/) is so slow that
I sometime wonder whether it is frozen or not. Having a small memory footprint
is a thing, being usable is another.

So let's introduce [Mutt](http://www.mutt.org), a clean and efficient
command-line based mail client.

> "Mutt is a small but very powerful text-based mail client for Unix
>  operating systems."
> ([mutt.org](http://www.mutt.org/))

I really love the customizability of Mutt, but its installation and
configuration are not really straightforward if you want to have a clean and
efficient application. Here is how I did. Please note that I am going to
describe *my* configuration, which is based upon Gmail IMAP accounts.  You may
have to sightly adapt it to your needs.

## Table of contents

{:toc}

## Prerequisites

I am going to assume that you are already familiar with OS X, its terminal and
UNIX command line basics. If you are not, well, Mutt is probably not for you,
yet if you really want to use it, there are plenty of resources online to learn
these things.

Furthermore, I am going to use [Homebrew](http://mxcl.github.com/homebrew/) to
install pieces of software. In order to install it, just run the following in
your terminal:

~~~ bash
ruby -e `$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)`
~~~

More detailed instructions are available on the [dedicated GitHub wiki
page](http://github.com/mxcl/homebrew/wiki/installation).


## May the keychain be with you

I hate storing my passwords in plaintext files. Really. So let's use Mac OS
X built-in keychain. First, you have to register your keys. Just open the
keychain utility (it is located in `/Applications/Utilities/`) and add one or
more "internet passwords". For instance:

![Keychain Example](/assets/images/posts/keychain.png)

Once you have registered all your keys, we have to write a simple Python
script, which will allows offlineimap (see bellow) to retrieve passwords from
the keychain. Create and fill `~/.mutt/offlineimap.py` with the following:

~~~ python
#!/usr/bin/python
import re, commands
def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server
    }
    command = "%(security)s %(command)s -g -a %(account)s -s %(server)s" % params
    outtext = commands.getoutput(command)
    return re.match(r'password: "(.*)"', outtext).group(1)
~~~

It's enough for the keychain integration. Let's move further with the offline
thing.

## Offline matters

First and foremost, e-mails must be available offline. Hopefully, a script has
already been written to achieve this, and it is called
[offlineimap](http://github.com/nicolas33/offlineimap), and is written by [John
Goerzen](http://changelog.complete.org/). It is now supported by Nicolas
Sebrecht.

### Installation

Download the latest trunk on GitHub, either by cloning the repository or
downloading the [automatically built source
archive](http://github.com/nicolas33/offlineimap/tarball/master). Once you've
got the source, just run

`python setup.py install`

### Configuration

Now we have to tell it where to put the the mail, and where to grab it from. So
create and edit `~/.offlineimaprc` with something like that (adapt to your
settings):

~~~ ini
[general]
ui = TTY.TTYUI
accounts = GMail, Pelletier
pythonfile=~/.mutt/offlineimap.py

[Account GMail]
localrepository = Gmail-Local
remoterepository = Gmail-Remote

[Account Pelletier]
localrepository = Pelletier-Local
remoterepository = Pelletier-Remote

[Repository Gmail-Local]
type = Maildir
localfolders = ~/Mail/GMail

[Repository Pelletier-Local]
type = Maildir
localfolders = ~/Mail/Pelletier

[Repository Gmail-Remote]
type = Gmail
remoteuser = pelletier.thomas@gmail.com
remotepasseval = get_keychain_pass(account="pelletier.thomas@gmail.com", server="imap.gmail.com")
realdelete = no
nametrans = lambda folder: re.sub('.*Spam$', 'spam', re.sub('.*Drafts$', 'drafts', re.sub('.*Sent Mail$', 'sent', re.sub('.*Starred$', 'flagged', re.sub('.*Trash$', 'trash', re.sub('.*All Mail$', 'archive', folder))))))

[Repository Pelletier-Remote]
type = Gmail
remoteuser = thomas@pelletier.im
remotepasseval = get_keychain_pass(account="thomas@pelletier.im", server="imap.gmail.com")
realdelete = no
nametrans = lambda folder: re.sub('.*Spam$', 'spam', re.sub('.*Drafts$', 'drafts', re.sub('.*Sent Mail$', 'sent', re.sub('.*Starred$', 'flagged', re.sub('.*Trash$', 'trash', re.sub('.*All Mail$', 'archive', folder))))))
~~~

As you can see, the configuration is the same for both GMail and Google Apps
accounts, and that we have to setup a mapping between GMail's folders and the
local ones. Now you can create `~/Mail`, test your configuration and do the
first synchronization (beware, it is going to be very long):

~~~ bash
mkdir ~/Mail && offlineimap -o
~~~

Once it works, we have to create a script and a Cron job to automate this job.
Here is the script (`~/.sync_mail.sh`, chmod to +x):

~~~ bash
#!/bin/sh
/usr/local/bin/offlineimap -o -c /Users/thomas/.offlineimaprc -u Noninteractive.Quiet
exit 0
~~~

And the Cron entry:

`*/3 * * * * /Users/thomas/.sync_mail.sh`

## Mutt, here we are

### Installation

Well, it's as easy as a `sudo brew install mutt`. If you want a sidebar
allowing you to navigate between your mailboxes, you can supply the
`--sidebar-patch` option to brew to make it apply the
[sidebar patch](https://raw.github.com/nedos/mutt-sidebar-patch/master/mutt-sidebar.patch):

~~~ bash
brew install --sidebar-patch
~~~

### Configuration

Mutt's configuration lives in the `~/.mutt` folder. Let's begin with
`~/.mutt/muttrc`:


~~~ bash
set editor = "mvim -f +/^$"
set mbox_type = Maildir
set folder = ~/Mail
set spoolfile = "+Pelletier/INBOX"
set mail_check = 0
unset move
set delete
unset confirmappend
set quit
unset mark_old
set beep_new
set edit_headers
set realname = "Thomas Pelletier"
set reply_to
set sort = threads
set sort_aux = reverse-last-date-received
mailboxes +GMail/INBOX +GMail/archive +GMail/sent +GMail/drafts +GMail/spam +GMail/trash
mailboxes +Pelletier/INBOX +Pelletier/archive +Pelletier/sent +Pelletier/drafts +Pelletier/spam +Pelletier/trash

folder-hook GMail/* source ~/.mutt/gmail.muttrc
folder-hook Pelletier/* source ~/.mutt/pelletier.mutrc
~~~

So, what is important here? The spoolfile is the default mailbox, the one which
opens when you fire Mutt. Folder-hooks allow us to define per mailbox
configuration, but it is not our topic. Finally, if you do not use macvim, or
don't want to use it to compose your e-mails, change the editor configuration.

![Mutt](/assets/images/posts/mutt.png)

Pretty cool isn't it? Now it's time to browse the web to find many Mutt
interface tweaks. If you want, you can take a look at
[my mutt configuration files](https://bitbucket.org/pelletier/dotfiles/src/tip/mutt/).
Have a lot of fun!

## Sources

When I set up my Mutt, I read pbrisbin's excellent [Two IMAP accounts in
Mutt](http://pbrisbin.com/posts/two_accounts_in_mutt/), and many others that
I forgot to bookmark.

## Edits

### August 07, 2011

* Offlineimap moved, and changed its maintainer.
* Don't forget to create the `~/Mail` directory.
* Add the sidebar patch option to the mutt installation.
* Add a link to my dot files.

### Older

* Thanks to [Steve Losh](http://twitter.com/stevelosh/) for pointing out all my
mistakes.
