---
title: Peer-produced plots
layout: post
categories: homework
comments: true
duedate: 2013-02-28
related: 2013-02-28-peer-produced-plots-solutions
---

# Time to match wits...

Your R Club buddies have been experimenting with ways to plot data with ggplot. Below is a sampling of their efforts. Your duty this week is to choose at least three plots and figure out how they were plotted.

If the datasets don't look familiar, be sure to scroll down to the 'Data' section of the [ggplot2 docs](http://docs.ggplot2.org/current/).




## Challenge 1

Stacey plotted movie rating since the dawn of cinematography (binned by density) .

![plot of chunk 2013-02-26-challenge01]({{ site.figurl }}/2013-02-26-challenge01.png)


## Challenge 2

Ciera plotted MPAA movie rating trends over the last couple decades.

![plot of chunk 2013-02-26-challenge02]({{ site.figurl }}/2013-02-26-challenge02.png)

<aside class="hint">
**Hint:** You need to subset the movies such that you are only considering movies with MPAA ratings since 1990.
</aside>

## Challenge 3

Miguel is a huge fan of the written word. One of his life goals is to bridge the gap between science and literature. He made this plot in hopes of advancing this cause.

![plot of chunk 2013-02-26-challenge03]({{ site.figurl }}/2013-02-26-challenge03.png)


## Challenge 4

Cody found a geom that can be used to compare distributions by plotting them along the axes. Can you find it, too?

![plot of chunk 2013-02-26-challenge04]({{ site.figurl }}/2013-02-26-challenge04.png)


## Challenge 5

For Valentine's Day, Jessica received a $20 gift card for a local gas station. Before she redeems it, she wants to find out which types of car will get her to the Bay Area and back on five gallons.

![plot of chunk 2013-02-26-challenge05]({{ site.figurl }}/2013-02-26-challenge05.png)



## Challenge 6

Hsin-Yen was curious about the terrain and altitude where various tomato species have been found in the wild.

![plot of chunk 2013-02-26-challenge06]({{ site.figurl }}/2013-02-26-challenge06.png)

<aside class="hint">

To get you started, I'll show you how to use the `get_map()` function from the `ggmap` library to extract a raster object of the map. (see pg. 11 of the [`ggmap` documentation](http://cran.r-project.org/web/packages/ggmap/ggmap.pdf))


```r
library(ggmap)
map <- get_map(location = c(lon = -75, lat = -16),
               zoom = 5,
               maptype = 'satellite')
```


**Hints:**

- Start by plotting the map image with the `ggmap()` function from the `ggmap` library (see pg. 18 of the [`ggmap` documentation](http://cran.r-project.org/web/packages/ggmap/ggmap.pdf))
- Add an additional layer with `geom_point()` (you'll need to specify the dataset to use inside `geom_point`)

</aside>

## Challenge 7

Not one to be outdone, Stacey demonstrates that she also knows the ways of the world by plotting the geographical position of tomato species collection points on top of not just a part of South America, but on top of the *entire* world.

![plot of chunk 2013-02-26-challenge07]({{ site.figurl }}/2013-02-26-challenge07.png)

<aside class="hint">
**Hints:**

- Start by plotting the world map using `geom_polygon()` with a data frame created with ggplot's `map_data()` function
- Add an additional layer with another geom

</aside>
