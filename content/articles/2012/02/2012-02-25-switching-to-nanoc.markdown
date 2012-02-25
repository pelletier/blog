---
title: Switching to nanoc, and more.
---

I started using a static website generator about a year ago. I really don't
regret the switch: working with text files and don't having to worry about
a sloppy, often poorly written blogging application is really nice. I have
always been using [Jekyll][]. Though it does its job quite well, I started
needing to write dirty hacks to make it work exactly the way I want.  So after
a year, I decided to take a look at the other static website generators. I tried
[Hyde][] (Jekyll's Python counterpart) and [Pelican][]. None of them was really
fitting my needs, and they all resulted in some more hacks.

Then, I found [nanoc][].

It is a really powerful static website generator written in Ruby. It is a bit
harder to get along with than the others, yet it turns out to be really
powerful: it leverages Ruby to provide a DSL used to set up a clever [set of
rules][] defining how your content will be compiled and where it will be placed
afterwards.

After a quick trial, I decided to start generating my website with nanoc, and to
make a few changes I wanted to do for a while. I began by relocating some files
and creating a year / month directory structure for the articles on the blog.
Then I ran some scripts to tweak of some things in the source code (URLs,
headings and so on) and wrote a few lines of Ruby code to run some optimizers
(such as YUI compressor). Here is the final [Routes file][].

Finally, I decided to implement the only feature I was missing from the time
I was using a dynamic platform ([Wordpress][] especially). It's the ability to
quickly edit an article (usually to fix a typo). Most of the time, I'm not in
front of my computer when I want to quickly edit a post. Even if I am, I have to
open a terminal, switch to the correct [RVM][] gemset, edit the post, and run
git-commit. That's quite a lot of work, just to add a missing s. I know this
workflow could be reduced, but not as much as would like.

So here is what I decided to do: leverage GitHub's built-in text editor to edit
my content online, without having to worry about the computer I'm on. So I wrote
a simple Ruby script, which starts the built-in server of [Sinatra][] and wait
for the request of a GitHub [post-receive hook][]. It then pulls the GitHub
repository, compiles using nanoc and move the file on the web server. Here is
the [build.rb][] file:

~~~ ruby
require 'sinatra'

$output_dir = "/home/thomas/www/thomas"
$logs_dir = "/home/thomas/logs/thomas"

configure do
  set :port, 9999
  set :bind, '127.0.0.1'
end

post '/' do
  current_dir = File.dirname(__FILE__)
  log_file = "#{$logs_dir}/#{Time.now.iso8601}"

  %x(cd #{current_dir} && git pull origin master)
  %x(cd #{current_dir} && nanoc compile > #{log_file})
  %x(rm -R #{$output_dir}/* 2>> #{log_file})
  %x(cd #{current_dir} && mv #{current_dir}/output/* #{$output_dir}/ 2>> #{log_file})
end
~~~

Pretty simple, uh? The rest of the work is done by [Nginx][]:

~~~ nginx
server {
    server_name thomas.pelletier.im;

    # Compression stuff

    location /hook {
        allow 207.97.227.253; # Only allow the two GitHub
        allow 50.57.128.197;  # IPs.
        deny all;

        rewrite .* / break;
        proxy_pass http://127.0.0.1:9999;
            proxy_set_header  X-Real-IP  $remote_addr;
    }

    location / {
        root /var/www/thomas;
        index index.html index.htm;

        # Some rewrite and cache stuff.
    }
}
~~~

Now I can quickly fix something. I would like to try this using only GitHub
Pages and Heroku, but I use YUI compressor, which requires Java, and I'm not
sure that we can use both Java and Ruby on the same Heroku instance. To be
investingaged.

[Jekyll]: http://ringce.com/hyde
[Hyde]: http://ringce.com/hyde
[Pelican]: http://pelican.readthedocs.org/
[nanoc]: http://nanoc.stoneship.org/
[set of rules]: http://nanoc.stoneship.org/docs/4-basic-concepts/#rules
[Routes file]: https://github.com/pelletier/blog/blob/master/Rules
[Wordpress]: http://wordpress.org/
[RVM]: http://beginrescueend.com/deployment/best-practices/
[Sinatra]: http://www.sinatrarb.com/
[post-receive hook]: http://help.github.com/post-receive-hooks/
[build.rb]: https://github.com/pelletier/blog/blob/master/build.rb
[Nginx]: http://nginx.org/
