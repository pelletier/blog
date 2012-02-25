--- 
title: Sync Google Contacts and AddressBook.app
---

You may be aware of some limitations you may encounter to sync your Google
Contacts with your built-in Mac OS X address book, especially if you don't have
an iPhone/iPod Touch. Here is the most suitable solution I found to get round
of this annoying problem.

 1. First of all, you must let your system think you have an iPod. Just open
    the file `~/Library/Prefereces/com.apple.iPod.plist`, and change the
    `FamilyID` to `1001`, then save it.  ![Property List
    Editor](http://media.tumblr.com/tumblr_kua6feLUcf1qaorng.png)
 2. Open your AdressBook.app, go to Preferences, then click Account button,
    pick the "Sync with Google" checkbox and click the "Configure" button on
    the right of the latest.  ![AdressBook
    preferences](http://media.tumblr.com/tumblr_kua6iwz7RW1qaorng.png) You will
    be prompted for you Google credentials.
 3. One last thing. Your contacts are **not** sync automatically when you edit
    some of them or when you quit AdressBook.app. You have to set up a small
    script which will be executed hourly (Note: this part uses the notion of
    [cron](http://en.wikipedia.org/wiki/Cron)). Create the file
    `~/Library/crontab`, and write the following line inside:

~~~ bash
@hourly /System/Library/PrivateFrameworks/GoogleContactSync.framework/Versions/A/Resources/gconsync --sync com.google.ContactSync
~~~

Then open your Terminal.app and invoke: crontab `~/Library/crontab`.

You should be ok, and your contacts will sync every hour. Have fun.
