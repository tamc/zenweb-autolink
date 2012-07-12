= zenweb-autolink

* Source :: http://github.com/tamc/zenweb-autolink

== DESCRIPTION:

A plugin for zenweb that automatically generates links between pages.

For example: If a page has a title attribute 'my page about zebweb' then
any other page that contains text like 'see my page about zenweb' would
have some of the text replaced with a link to that page: 
'see <a href='/zenweb.html'>my page about zenweb</a>'

== FEATURES/PROBLEMS:

* Only replaces text with links if the text is part of a paragraph or 
  list (i.e., won't create links in titles or inside other links)
* Works on any html
* But, doesn't allow you to specify when links do or don't occur

== SYNOPSIS:

See test_site directory for an example of its usage.


1 Add `require 'zenweb-autolink'`
2 Make sure some of your pages have title attributes (i.e., they have a
  _config.yml file or config block that has title: tile at the top)
3 Add the extension .autolink to pages that you want the autolinker to operate on
  (it is best to put the extension immediately after the '.html' extension)

== REQUIREMENTS:

* Zenweb 3.0.0.b3 or later

== INSTALL:

  sudo gem install zenweb-autolink  

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2012 Tom Counsell

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
