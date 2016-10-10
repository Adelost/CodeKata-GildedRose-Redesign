assert = require "assert"
Logic = require "./Logic"

describe "createItem", ->
  it "creates an item from id", ->
    # when
    item = Logic.createItem "sulfuras"
    # then
    assert.equal item.name, "Sulfuras, Hand of Ragnaros"
    assert.equal item.quality, 80
  it "can use options", ->
    # when
    item = Logic.createItem "brie",
      quality: 10
    # then
    assert.equal item.quality, 10
    assert.equal item.improveWithTime?, true

describe "item", ->
  describe "quality", ->
    it "remains unchanged by default", ->
      # given
      item =
        quality: 1
      # when
      Logic.update item
      # then
      assert.equal item.quality, 1

  describe "daysLeft", ->
    # given
    item =
      daysLeft: 1
    it "reduces over time", ->
      # when
      Logic.update item
      # then
      assert.equal item.daysLeft, 0
    it "can be negative", ->
      # when
      Logic.update item
      # then
      assert.equal item.daysLeft, -1

  describe "degrade", ->
    it "reduces quality over time", ->
      # given
      item =
        quality: 10
        daysLeft: 10
        degrade: true
      # when
      Logic.update item
      # then
      assert.equal item.quality, 9
    it "reduces quality by specified amount", ->
      # given
      item =
        quality: 10
        daysLeft: 10
        degrade:
          amount: 3
      # when
      Logic.update item
      # then
      assert.equal item.quality, 7
    it "reduces faster when expired", ->
      # given
      item =
        quality: 10
        daysLeft: 0
        degrade: true
      # when
      Logic.update item
      # then
      assert.equal item.quality, 9
      assert.equal item.daysLeft, -1
      # when
      Logic.update item
      # then
      assert.equal item.quality, 7
      assert.equal item.daysLeft, -2
    it "cannot reduce below zero", ->
      # given
      item =
        quality: 1
        daysLeft: 1
        degrade: true
      # when
      Logic.update item
      # then
      assert.equal item.quality, 0
      assert.equal item.daysLeft, 0
      # when
      Logic.update item
      # then
      assert.equal item.quality, 0
      assert.equal item.daysLeft, -1

  describe "expire", ->
    it "reduces quality to zero after expiry date", ->
      # given
      item =
        quality: 10
        daysLeft: 0
        degrade: true
        expire: true
      # when
      Logic.update item
      # then
      assert.equal item.quality, 9
      # when
      Logic.update item
      # then
      assert.equal item.quality, 0
      # when
      Logic.update item
      # then
      assert.equal item.quality, 0

  describe "improveWithTime", ->
    it "improves quality over time", ->
      # given
      item =
        quality: 0
        daysLeft: 1
        improveWithTime: true
      # when
      Logic.update item
      # then
      assert.equal item.quality, 1
      # when
      Logic.update item
      # then
      assert.equal item.quality, 2
    it "cannot improve beyond max", ->
      # given
      item =
        quality: 0
        daysLeft: 1
        improveWithTime:
          max: 1
      # when
      Logic.update item
      # then
      assert.equal item.quality, 1
      # when
      Logic.update item
      # then max reached
      assert.equal item.quality, 1
    it "improves faster with tiers", ->
      # given
      item =
        quality: 0
        daysLeft: 4
        improveWithTime:
          tiers: [3, 2, 1]
      # when
      Logic.update item
      # then increase by 1 (tier 0, days 4)
      assert.equal item.quality, 1
      # when
      Logic.update item
      # then increase by 2 (tier 1, days 3)
      assert.equal item.quality, 3
      # when
      Logic.update item
      # then increase by 3 (tier 2, days 2)
      assert.equal item.quality, 6
      # when
      Logic.update item
      # then increase by 4 (tier 3, days 1)
      assert.equal item.quality, 10
      # when
      Logic.update item
      # then increase by 4 (tier 3, days 1)
      assert.equal item.quality, 14

