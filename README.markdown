Lokka-Disqus
============

This plugin adds [DISQUS](http://disqus.com/) comment form to [Lokka](http://lokka.org).

Install
-------

    $ cd /path/to/lokka/
    $ cd public/plugin
    $ git clone git://github.com/satococoa/lokka-disqus.git

How to use
----------

This plugin adds 2 helpers and a plugin configure page.
Configure your "Website shortname"(see: disqus Settings page) in the plugin configure page.
Then, add codes below into your favorite theme.

- `<%= comment_form %>`

    shows disqus comment form.

- `<%= comments_link(post.id, post.link) %>`

    shows link for comment form.
    also, this shows the number of comment for the given post.
    ex) 3 Comments
