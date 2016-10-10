Item = (name, sell_in, quality) ->
  @name = name
  @sell_in = sell_in
  @quality = quality
  return

class Item
  constructor: (@name, @sell_in, @quality) ->

items = [
  new Item("+5 Dexterity Vest", 10, 20),
  new Item("Aged Brie", 2, 0),
  new Item("Elixir of the Mongoose", 5, 7),
  new Item("Sulfuras, Hand of Ragnaros", 0, 80),
  new Item("Sulfuras, Hand of Ragnaros", -1, 80),
  new Item("Backstage passes to a TAFKAL80ETC concert", 15, 20),
  new Item("Backstage passes to a TAFKAL80ETC concert", 10, 49),
  new Item("Backstage passes to a TAFKAL80ETC concert", 5, 49),
  new Item("Conjured Mana Cake", 3, 6);
]

update_quality = ->
  i = 0
  while i < items.length
    if items[i].name != 'Aged Brie' and items[i].name != 'Backstage passes to a TAFKAL80ETC concert'
      if items[i].quality > 0
        if items[i].name != 'Sulfuras, Hand of Ragnaros'
          items[i].quality = items[i].quality - 1
    else
      if items[i].quality < 50
        items[i].quality = items[i].quality + 1
        if items[i].name == 'Backstage passes to a TAFKAL80ETC concert'
          if items[i].sell_in < 11
            if items[i].quality < 50
              items[i].quality = items[i].quality + 1
          if items[i].sell_in < 6
            if items[i].quality < 50
              items[i].quality = items[i].quality + 1
    if items[i].name != 'Sulfuras, Hand of Ragnaros'
      items[i].sell_in = items[i].sell_in - 1
    if items[i].sell_in < 0
      if items[i].name != 'Aged Brie'
        if items[i].name != 'Backstage passes to a TAFKAL80ETC concert'
          if items[i].quality > 0
            if items[i].name != 'Sulfuras, Hand of Ragnaros'
              items[i].quality = items[i].quality - 1
        else
          items[i].quality = items[i].quality - (items[i].quality)
      else
        if items[i].quality < 50
          items[i].quality = items[i].quality + 1
    i++
  return