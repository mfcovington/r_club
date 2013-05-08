---
title:      News archive
layout:     post
categories: news
comments:   true

announcements:

# Place new announcements at the top of the stack (i.e., reverse chronological
# order). If no announcement is desired for the front page, use an entry with
# no values for the first 'date'/'text' key combo.

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
