---
title:      News archive
layout:     post
categories: news
comments:   true

announcements:

# Place new announcements at the top of the stack (i.e., reverse chronological
# order). If no announcement is desired for the front page, use an entry with
# no values for the first 'date'/'text' key combo.

 - date: 2016-01-19
   text: R Club is being revived!  There will be a focus on learning Bayesian statistics using Richard McElreath's book [Statistical Rethinking](http://xcelab.net/rm/statistical-rethinking/).  More info soon.

 - date: 2013-05-15
   text: I think our last git discussion quickly grew too complicated. I've added a new resource that demonstrates the basics of git as well as a simple homework assignment to put what you learn to use. Also, Stacey will be giving a short presentation on the VennDiagram R package

 - date: 2013-05-06
   text: Answers for regex exercises are due Thursday (2013-05-09) by 2PM. This week we will cover the use of git (a version control system for keeping track of changes in your code). In preparation, be sure to do the short homework for this week before we meet.

 - date:
   text:

---

<div>
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
</div>
