---
title: Peer-produced plots (solutions)
layout: post
categories: solutions
comments: true
duedate:
related: 2013-02-26-peer-produced-plots
---

***in progress***

# And wits were matched.

Your R Club buddies have been experimenting with ways to plot data with ggplot. Below is a sampling of their efforts. Your duty this week was to choose at least three plots and figure out how they were plotted.

## Getting ready

We'll start by reading in the Tomato Dataset and getting rid of `NA` values.


```r
tomato <- read.table("TomatoR2CSHL.csv", header = T, sep = ",")
tomato <- na.omit(tomato)
library(ggplot2)
```


In addition to the Tomato Dataset that we've been using, people have made plots with the `movies` and `mpg` datasets (which come with ggplot2 and are, therefore, loaded with `library(ggplot2)`). If the datasets don't look familiar, be sure to scroll down to the 'Data' section of the [ggplot2 docs](http://docs.ggplot2.org/current/).

## Challenge 1

Stacey plotted movie rating since the dawn of cinematography (binned by density) .

#### Figure 1A:

![plot of chunk 2013-02-26-challenge01]({{ site.figurl }}/2013-02-26-challenge01.png)


**Figure 1A** uses `stat_binhex()` to plot movie `rating` by `year`. As described in the [docs](http://docs.ggplot2.org/current/stat_binhex.html), `stat_binhex` bins a 2-dimensional plane into hexagons. By default, the hexagons are colored based on the number of counts in each hexagon; however, Stacey manually set the `fill = ..density..` when she made her plot:


```r
ggplot(movies) +
  stat_binhex(aes(x    = year,
                  y    = rating,
                  fill = ..density..),
              color = "black") +
  scale_fill_gradientn(colours = rainbow(7))
```


In this case, the only real difference between counts and density is seen with the scale bar in the legend. Below (**Fig. 1B**) is the same plot, but with the default fill (i.e., counts) being used. The graphical regions of the plot **Figures 1A** and **1B** are identical.

#### Figure 1B:


```r
ggplot(movies) +
  stat_binhex(aes(x = year,
                  y = rating),
              color = "black") +
  scale_fill_gradientn(colours = rainbow(7))
```

![plot of chunk 2013-02-26-challenge01b]({{ site.figurl }}/2013-02-26-challenge01b.png)


However, if we were to instead make this plot faceted, we begin to see the difference between the 'counts' and 'density'. The next two figures are faceted by whether the movie being considered is a drama. The first one shows that with the default method, the fill color is scaled relative to all the data for the entire plot (**Fig. 1C**), whereas mapping `fill = ..density..` results in the data within each panel being scaled relative to the relevant panel (**Fig. 1D**).

#### Figure 1C:


```r
ggplot(movies) +
  stat_binhex(aes(x = year,
                  y = rating),
              color = "black") +
  scale_fill_gradientn(colours = rainbow(7)) +
  facet_grid(. ~ Drama)
```

![plot of chunk 2013-02-26-challenge01c]({{ site.figurl }}/2013-02-26-challenge01c.png)


#### Figure 1D:


```r
ggplot(movies) +
  stat_binhex(aes(x    = year,
                  y    = rating,
                  fill = ..density..),
              color = "black") +
  scale_fill_gradientn(colours = rainbow(7)) +
  facet_grid(. ~ Drama)
```

![plot of chunk 2013-02-26-challenge01d]({{ site.figurl }}/2013-02-26-challenge01d.png)


When reproducing this plot, many people had issues with setting the border of each hexbin to black. To set the color successfully, you need to remember two things:

- The color of lines, dots, borders, etc. is specified with `color` and the fill color for shapes with `fill`.
- When you are mapping a data attribute to a graphical attribute, you specify that inside `aes()`; however, when setting a graphical attribute to a specific value, color, etc., it needs to be done *outside* of `aes()`. I've formatted the indentation pattern of the code snippets above to reinforce the fact that `x`, `y`, and, `fill` are aesthetics, but `color` is not.

<aside class="warn">
**Warning:** Most of the time, ggplot2 accepts `color` and `colour` interchangeably; however, inside `scale_fill_gradientn()` is currently an exception and `colour` must be used.
</aside>

## Challenge 2

Ciera plotted MPAA movie rating trends over the last couple decades.

#### Figure 2:

![plot of chunk 2013-02-26-challenge02]({{ site.figurl }}/2013-02-26-challenge02.png)


We need to start by sub-setting the movies such that we are only considering movies with MPAA ratings since 1990.


```r
movies.mpaa.new <- subset(movies, mpaa != "" & year >= 1990)
```


For this plot, we'll assign each part of the plot to a separate variable and then combine them to generate the plot.

For the base of the plot, we specify the data subset (`movies.mpaa.new`) that we just created and map the aesthetics `x` and `fill`. Unlike `stat_binhex()` plots, `color` in a `geom_density()` plot defaults to black so we don't need to set it.


```r
base <- ggplot(movies.mpaa.new,
               aes(x    = year,
                   fill = mpaa))
```


Next, we specify the `geom_density()` layer. In order to see the densities for each MPAA rating, we need to change `alpha` (the transparency setting). For her plot, Ciera set `alpha = 1/2`. Note that it is not inside `aes()`, because we are setting it to an absolute value rather than mapping it to a data attribute. Also, we must place it inside `geom_density()`, not `ggplot()`. Typically, you only specify the dataset and aesthetics with `ggplot()`.


```r
density <- geom_density(alpha = 1/2)
```


Using `labs()`, we can customize the labels for the entire plot, the axes, and/or the legend scales.


```r
label <- labs(title = "The Density Distribution of MPAA Rated Films from 1990-2005")
```


To move the legend from the right-side of the figure to the bottom, we can set the `legend.position` element with `theme()`.


```r
theme.custom <- theme(legend.position = "bottom")
```

<aside class="warn">
**Warning:** Remember that customizing the look of ggplots with `opts()` has been deprecated. If you are using `opts()`, find a different way to accomplish what you want. Even if `opts()` might work for you now, the functionality could change or break with any new release of ggplot2.
</aside>

Now that we've defined each component of **Figure 2**, we can put them together like this:


```r
base + density + label + theme.custom
```

I won't bother actually plotting this here, because it will be identical to **Figure 2**; however, I hope you can see the potential here for highly-readable modular customization. Rather than copy and pasting a big chunk of code for making small changes to create new plots, you can assign to variables any parts that you want to remain constant between your plots.

## Challenge 3

Miguel is a huge fan of the written word. One of his life goals is to bridge the gap between science and literature. He made this plot in hopes of advancing this cause.

#### Figure 3A:

![plot of chunk 2013-02-26-challenge03]({{ site.figurl }}/2013-02-26-challenge03.png)

**Figure 3A** can be generated with:


```r
ggplot(tomato, aes(x     = alt,
                   y     = hyp,
                   size  = leafnum,
                   label = species,
                   color = trt,
                   angle = 30)) +
  geom_text() +
  facet_grid(. ~ who) +
  labs(title = "TOMATO DATA IN WORDS",
       x     = "ALTITUDE",
       y     = "HYPOCOTYL LENGTH")
```


Here, we see `geom_text()` in action. As usual, we start by specifying the dataset and aesthetics within `ggplot()`. If you look closely, you'll notice that `angle` is the exception to the rule regarding mapping vs. setting. Even though we are setting `angle = 30` rather than mapping it to a parameter from the dataset, it must be placed inside `aes()`. Putting it in what should be the proper place (`geom_text(angle = 30)`), causes the words to be plotted at a 30° angle, but also results in the letters in the legend to be angled as shown in **Figure 3B**.

#### Figure 3B:


```r
ggplot(tomato, aes(x     = alt,
                   y     = hyp,
                   size  = leafnum,
                   label = species,
                   color = trt)) +
  geom_text(angle = 30) +
  facet_grid(. ~ who) +
  labs(title = "TOMATO DATA IN WORDS",
       x     = "ALTITUDE",
       y     = "HYPOCOTYL LENGTH")
```

![plot of chunk 2013-02-26-challenge03b]({{ site.figurl }}/2013-02-26-challenge03b.png)


I think either approach is reasonable, but the legend in **Figure 3A** looks a bit more clean to me. As for the other parts of the code, note how `labs()` is used to specify labels for the entire plot and both axes. A less elegant, yet completely functional alternative approach is:


```r
+ ggtitle("TOMATO DATA IN WORDS") +
  xlab("ALTITUDE") +
  ylab("HYPOCOTYL LENGTH")
```


## Challenge 4

Cody found a geom that can be used to compare distributions by plotting them along the axes. Can you find it, too?

#### Figure 4:

![plot of chunk 2013-02-26-challenge04]({{ site.figurl }}/2013-02-26-challenge04.png)



```r
ggplot(tomato, aes(x      = leafleng,
                   y      = leafwid,
                   colour = who)) +
    geom_point() +
    geom_rug() +
    labs(x = "Leaf Length (mm)",
         y = "Leaf Width (mm)") +
    theme(aspect.ratio = 1)
```


## Challenge 5

For Valentine's Day, Jessica received a $20 gift card for a local gas station. Before she redeems it, she wants to find out which types of car will get her to the Bay Area and back on five gallons.

#### Figure 5:

![plot of chunk 2013-02-26-challenge05]({{ site.figurl }}/2013-02-26-challenge05.png)



```r
ggplot(mpg, aes(x      = class,
                y      = hwy,
                colour = manufacturer,
                fill   = manufacturer)) +
  geom_dotplot(binaxis      = "y",
               stackdir     = "center",
               binpositions = "all") +
  labs (x = "Class",
        y = "Highway (mpg)") +
  theme(aspect.ratio = 0.5,
        axis.text.x  = element_text(angle = 45))
```


## Challenge 6

Hsin-Yen was curious about the terrain and altitude where various tomato species have been found in the wild.

#### Figure 6A:

![plot of chunk 2013-02-26-challenge06]({{ site.figurl }}/2013-02-26-challenge06.png)

<aside class="hint">

To get you started, I'll show you how to use the `get_map()` function from the `ggmap` library to extract a raster object of the map. (see pg. 11 of the [`ggmap` documentation](http://cran.r-project.org/web/packages/ggmap/ggmap.pdf)):

```r
library(ggmap)
map <- get_map(location = c(lon = -75, lat = -16),
               zoom     = 5,
               maptype  = 'satellite')
```

**Hints:**

- Start by plotting the map image with the `ggmap()` function from the `ggmap` library (see pg. 18 of the [`ggmap` documentation](http://cran.r-project.org/web/packages/ggmap/ggmap.pdf))
- Add an additional layer with `geom_point()` (you'll need to specify the dataset to use inside `geom_point`)

</aside>

#### Figure 6B:


```r
ggmap(map)
```

![plot of chunk 2013-02-26-challenge06b]({{ site.figurl }}/2013-02-26-challenge06b.png)



```r
ggmap(map) +
  geom_point(aes(x      = lon,
                 y      = lat,
                 colour = alt),
             data = tomato,
             size = 2) +
  facet_grid(. ~ species) +
  scale_colour_continuous(low  = "white",
                          high = "red")
```



## Challenge 7

Not one to be outdone, Stacey demonstrates that she also knows the ways of the world by plotting the geographical position of tomato species collection points on top of not just a part of South America, but on top of the *entire* world.

#### Figure 7A:

![plot of chunk 2013-02-26-challenge07]({{ site.figurl }}/2013-02-26-challenge07.png)

<aside class="hint">

**Hints:**

- Start by plotting the world map using `geom_polygon()` with a data frame created with ggplot's `map_data()` function
- Add an additional layer with another geom

</aside>

#### Figure 7B:


```r
world <- map_data("world")
worldmap <- ggplot(world, aes(x     = long,
                              y     = lat,
                              group = group)) +
  geom_polygon(fill   = "white",
               colour = "black")
worldmap
```

![plot of chunk 2013-02-26-challenge07a]({{ site.figurl }}/2013-02-26-challenge07a.png)




```r
worldmap +
  geom_point(aes(x     = lon,
                 y     = lat,
                 group = NULL),
             data  = tomato,
             size  = 2,
             color = "red")
```


