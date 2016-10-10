Data = require "./Data"

exports.attributes =
  name: true
  quality: true

exports.behaviors =
  degrade: (item, opt) ->
    amount = opt.amount ? 1
    amount *= 2 if utils.expired item
    item.quality -= amount
    item.quality = 0 if item.quality < 0

  improveWithTime: (item, opt) ->
    amount = 1
    if opt.tiers?
      for tier in opt.tiers when item.daysLeft <= tier
        amount += 1
    item.quality += amount
    if opt.max? and item.quality > opt.max
      item.quality = opt.max

  expire: (item) ->
    item.quality = 0 if utils.expired item

  daysLeft: (item) ->
    item.daysLeft -= 1

exports.update = (item) ->
  for key, behavior of exports.behaviors when key of item
    options = item[key]
    behavior item, options
  return

exports.createItem = (id, opt = {}) ->
  template = Data.items[id]
  if not template?
    return null
  item = utils.clone template
  for key, value of opt
    item[key] = value
  item

utils =
  expired: (item)-> item.daysLeft < 0
  clone: (obj) -> JSON.parse(JSON.stringify(obj))
