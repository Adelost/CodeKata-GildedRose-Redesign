exports.items =
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

  elixir:
    name: "Elixir of the Mongoose"
    quality: 7
    daysLeft: 5
    degrade: true

  sulfuras:
    name: "Sulfuras, Hand of Ragnaros"
    quality: 80

  ticket:
    name: "Backstage passes to a TAFKAL80ETC concert"
    quality: 20
    daysLeft: 15
    improveWithTime:
      max: 50,
      tiers: [10, 5]
    expire: true

  cake:
    name: "Conjured Mana Cake"
    quality: 6
    daysLeft: 3
    degrade:
      amount: 2





