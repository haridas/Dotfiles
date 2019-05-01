My Dot Files
============

This repository keeps all of my Dot files, which are compatible with Gnu/Linux
machines. It includes dot files for VIM and Bash right now.

Quick Setup
===========

Gnu/Linux Environment
--------------------

```bash
wget -q https://raw.githubusercontent.com/haridas/Dotfiles/master/linux-setup.sh -O - | bash

```

Mac
---

```bash
wget -q https://raw.githubusercontent.com/haridas/Dotfiles/master/mac-setup.sh -O - | bash
```

Vim Environment
---------------

My VIM was initially setup for developing python projects. But lately I added 
support for golang and scala, by default vim can be used for editing any text
content, we add some plugins to get some extra features for some programming
languages.  So you can use it for all general type
programming and editing normal files

General purpose plugins are:-

1. Command-T    - Fuzzy file search.
2. minibufexpl  - Show vim buffers on separate virtual tabs.
3. nerdtree     - File browser for vim.
4. syntastic    - Syntax checker for different file types.
5. tagbar       - Ctag based File analyzer.

Language Specific plugins:-

1. rope - For python code inspection.
2. vim-go - For better golang support
3. scala-vim - For better scala support.

If any of you are interested to try out my vim setup you can run the following
command to install this vim setup.


How to Install
--------------

Read installation steps given on my blog
- http://haridas.in/vim-as-your-ide.html#setup-vim-from-scratch


More Details
------------
I wrote a blog post to explain more about vim environment setup and make it look
like an IDE. You can read it from this link - http://haridas.in/vim-as-your-ide.html

NOTE: The blog was written two years back, so some of the plugins are not being
there right now on my github repo. Some of them are removed because it doesn't
help much and some other plugins are being added to work with new
projects.


Screenshots
-----------

.. image:: ./screenshots/vim.png
        :alt: Vim-screenshot-1

.. image:: ./screenshots/vim1.png
      :alt: vim-screenshots-2
      

Thank you.
