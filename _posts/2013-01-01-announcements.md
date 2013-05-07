---
title: News archive
layout: post
categories: news
comments: true
author: 

# test
announcements:
 - date: 2013-05-06
   text: Answers for regex exercises are due Thursday (2013-05-09) by 2PM. This week we will cover the use of git (a version control system for keeping track of changes in your code). In preparation, be sure to do the short homework (which will be posted Tuesday) for this week before we meet.
 - date:
   text:
---

<h3>Past announcements</h3>

{% for post in site.posts %}
  {% if post.categories.first == 'news' %}
    {% for announce in post.announcements %}
      {% unless announce.date == null %}
<p><strong>{{ announce.date }}:</strong> {{ announce.text }}</p>
      {% endunless %}
    {% endfor %}
  {% endif %}
{% endfor %}
