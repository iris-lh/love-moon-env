utils = {
  uuid: ->
    random = math.random
    template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    output = string.gsub(template, '[xy]', (c)->
      v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
      return string.format '%x', v
    )
    return output
}



-- return utils
