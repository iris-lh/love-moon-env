-- conf = require 'conf'



userInput = (state, camera) ->
  m = love.physics.getMeter!
  ctrl = conf.controls
  player = state.objects.player

  if love.keyboard.isDown ctrl.left
    player.body\applyForce -5*m, 0

  if love.keyboard.isDown ctrl.right
    player.body\applyForce 5*m, 0


  love.keypressed = (key)->

    if key == ctrl.reset
      love.load!

    if key == 'c'
      print 'player collisions:'
      for i, collision in pairs player.collisions
        print collision

    if key == ctrl.jump
      velX, velY = player.body\getLinearVelocity!
      player.body\applyForce 0, -200*m



  love.wheelmoved = (x, y)->
    -- Zoom in and out
    newMeter = m + y

    if newMeter > 0
      cameraFocusPreviousX = camera.focus.getX!
      cameraFocusPreviousY = camera.focus.getY!

      love.physics.setMeter m + y

      camera.x += cameraFocusPreviousX - camera.focus.getX!
      camera.y += cameraFocusPreviousY - camera.focus.getY!
    else
      love.physics.setMeter 1
