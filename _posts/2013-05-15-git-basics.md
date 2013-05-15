---
title:      Git basics
layout:     post
categories: resources
comments:   true
duedate:
related:    
author:     Mike Covington
---

<aside class="hint">
The instructions below are for OS X. If you are using Windows, type `CTRL` instead of `⌘` where appropriate. If there are other significant differences, please leave a comment or send me an email.</aside>

# Create a new repository, make several commits, and push to GitHub/Bitbucket

## Creating a new git repository in SourceTree:

In SourceTree, Bring up the 'New Repository' window by typing `⌘+N` or clicking the `Add Repository` button. There are three ways to add repositories with this window:

- **Clone Repository**: Makes a copy of an existing git repository. The existing repo could be either local (elsewhere on your hard drive) or remote (e.g., on GitHub/Bitbucket).
- **Add Working Copy**: Adds an existing local git repository to SourceTree.
- **Create Repository**: Creates a new, empty local git repository.

![Create Repository]({{ site.figurl }}/git.create-repo.png)

Choose `Create Repository` and click the `…` to the far right of 'Destination Path' to choose a location for your new git repository. By default, the bookmark name will be the name of the directory containing the git repository. Double click the new bookmark entry to open your new empty git repository.

#### A video demonstrating the full process:

<iframe width="560" height="315" src="http://www.youtube.com/embed/6uB9g9J-290" frameborder="0" allowfullscreen></iframe>

## Making a series of commits in SourceTree:

The simplest workflow for using git consists of three repeated steps:

1. **Edit** content
2. **Add** changes to git index (aka **staging**)
3. **Commit** staged changes permanently to the git repository

#### A video demonstrating the creation of a series of commits:

<iframe width="560" height="315" src="http://www.youtube.com/embed/S6BJQC6lTO8" frameborder="0" allowfullscreen></iframe>

# Pushing a local git repository to GitHub/Bitbucket

Having your code accessible from a remote repository has several advantages, such as:

- Helping you keep projects in sync across your home and work computers
- Facilitating collaboration
- Showcasing your work

To make your git repository available remotely, you can **push** a local repository to a remote destination.

#### A video demonstrating how to add and push to remote repositories:

<iframe width="560" height="315" src="http://www.youtube.com/embed/Hs_Z99nOKM8" frameborder="0" allowfullscreen></iframe>





