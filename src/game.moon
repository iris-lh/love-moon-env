-- conf = require 'conf'
-- utils = require './utils.moon'
-- userInput = require './user-input.moon'
-- Player = require './player.moon'
-- Block = require './block.moon'
-- Ground = require './ground.moon'



love.load = ->
  print 'loading...'
  love.graphics.setBackgroundColor 104, 136, 248
  love.physics.setMeter 64
  m = love.physics.getMeter!
  export world = love.physics.newWorld 0*m, 9.81*m, true
  export state = {
    objects: {
      player: Player {x: 10*m, y: 5*m, r: 1/3*m}
      Ground {x: 5*m, y: 10*m, w: 30*m, h: 0.9*m}
      Block {x: 3*m, y: 8*m, w: 0.8*m, h: 1.5*m}
      Block {x: 3*m, y: 5*m, w: 1.5*m, h: 0.8*m}
    }
    winZone: {
      x: -9*m
      y: 6.5*m
      w: 3*m
      h: 3*m
    }
    gameWon: false
    debug: {
      collisions: {
        text: ""
        persisting: 0
      }
    }
  }
  export camera = Camera state.objects.player
  world\setCallbacks(beginContact, endContact, preSolve, postSolve)

  print 'done'



love.update = (dt)->
  m = love.physics.getMeter!
  userInput state, camera
  world\update dt
  camera\update dt

  for i,object in pairs state.objects
    object\update dt

  state.winZone = {
      x: -9*m
      y: 6.5*m
      w: 3*m
      h: 3*m
    }

  winZoneLeft = state.winZone.x
  winZoneRight = state.winZone.x + state.winZone.w
  winZoneTop = state.winZone.y
  winZoneBottom = state.winZone.y + state.winZone.h

  playerX = state.objects.player.body\getX!
  playerY = state.objects.player.body\getY!

  if playerX < winZoneRight and
    winZoneLeft < playerX and
    playerY < winZoneBottom and
    winZoneTop < playerY
      state.gameWon = true

  -- DEBUG
  if (string.len state.debug.collisions.text) > 768
    state.debug.collisions.text = ""



love.draw = ->
  winW, winH = love.window.getMode!
  camera\draw!

  -- DRAW OBJECTS
  love.graphics.setColor 255, 255, 0, 255
  love.graphics.rectangle 'fill', state.winZone.x, state.winZone.y, state.winZone.w, state.winZone.h

  for i,object in pairs state.objects
    object\draw!


  -- UI
  camera\ignore!

  if state.gameWon
    love.graphics.setColor( 0, 0, 0, 100 )
    love.graphics.rectangle 'fill', winW/2 - 50, winH/2 - 10, 100, 20
    love.graphics.setColor( 255, 255, 255, 255 )
    love.graphics.print 'You Won!', winW/2 - 28, winH/2 - 7

  -- DEBUG
  love.graphics.setColor( 0, 0, 0, 100 )
  love.graphics.rectangle 'fill', 0, 0, 715, 250

  love.graphics.setColor( 255, 255, 255, 255 )
  love.graphics.print '-- DEBUG --', 10, 10
  love.graphics.printf state.debug.collisions.text, 10, 25, 700



export getObjectByUserId = (id, objects) ->
  for i, object in pairs objects
    if object.id == id
      return object

export beginContact = (a, b, coll)->
  x, y = coll\getNormal()
  state.debug.collisions.text = state.debug.collisions.text.."\n"..a\getUserData().name.." colliding with "..b\getUserData().name.." with a vector normal of: "..x..", "..y

  subject = getObjectByUserId a\getUserData().id, state.objects
  object = getObjectByUserId b\getUserData().id, state.objects
  table.insert subject.collisions, {object: object, normal: {x: x, y: y}}

export endContact = (a, b, coll)->
  state.debug.collisions.persisting = 0
  state.debug.collisions.text = state.debug.collisions.text.."\n"..a\getUserData().name.." uncolliding with "..b\getUserData().name

export preSolve = (a, b, coll)->
  if state.debug.collisions.persisting == 0 then
    state.debug.collisions.text = state.debug.collisions.text.."\n"..a\getUserData().name.." touching "..b\getUserData().name
  elseif state.debug.collisions.persisting < 20 then
    state.debug.collisions.text = state.debug.collisions.text.." "..state.debug.collisions.persisting
  state.debug.collisions.persisting = state.debug.collisions.persisting + 1

export postSolve = (a, b, coll, normalimpulse, tangentimpulse)->



return
