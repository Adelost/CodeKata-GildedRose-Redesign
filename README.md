# GildedRose Redesign

## Info

My redesign of the [Gilded Rose][gildedrose] coding kata, using a data driven functional 
oriented approach. The challenge lies in refactoring a deeply nested 
block of if else statement and add support for a new item type.

The original design explicitly states that the item class is not allowed to be changed. However I wanted to 
reimagine how the design could look like given free reins.

In short, new items are defined by their attributes in [Data.coffee](src/Data.coffee) which is acted upon by [Logic.coffee](src/Logic.coffee). 
This makes it very flexible to make adjustments or to add new items, as well as adding new logic and attributes.

Example of defining items:
```
  sulfuras:
    name: "Sulfuras, Hand of Ragnaros"
    quality: 80
    
  vest:
    name: "+5 Dexterity Vest"
    quality: 20
    daysLeft: 10
    degrade: true

  brie:
    name: "Aged Brie"
    quality: 0
    daysLeft: 2
    improveWithTime:
      max: 50

  ticket:
    name: "Backstage passes to a TAFKAL80ETC concert"
    quality: 20
    daysLeft: 15
    improveWithTime:
      max: 50,
      tiers: [10, 5]
    expire: true
```

## Compilation

Written in [CoffeeScript][coffee] with [NodeJS][nodejs] and [Mocha][mocha].

## Gilded Rose Requirements Specification

Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a
prominent city ran by a friendly innkeeper named Allison. We also buy and sell only the finest goods.
Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We
have a system in place that updates our inventory for us. It was developed by a no-nonsense type named
Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that
we can begin selling a new category of items. First an introduction to our system:

    - All items have a SellIn value which denotes the number of days we have to sell the item
    - All items have a Quality value which denotes how valuable the item is
    - At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

    - Once the sell by date has passed, Quality degrades twice as fast
    - The Quality of an item is never negative
    - "Aged Brie" actually increases in Quality the older it gets
    - The Quality of an item is never more than 50
    - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
    - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

    - "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything
still works correctly. However, do not alter the Item class or Items property as those belong to the
goblin in the corner who will insta-rage and one-shot you as he doesn't believe in shared code
ownership (you can make the UpdateQuality method and Items property static if you like, we'll cover
for you).

Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
legendary item and as such its Quality is 80 and it never alters.


## Licence

The MIT License (MIT). The full license is found in the included `LICENSE` file.

[gildedrose]: https://github.com/emilybache/GildedRose-Refactoring-Kata
[coffee]: http://coffeescript.org/
[nodejs]: https://nodejs.org/en/
[mocha]: https://mochajs.org/
