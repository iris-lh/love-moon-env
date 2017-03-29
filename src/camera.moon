class Camera
  new: (focus)=>
    winW, winH = love.window.getMode!
    @focus = {
      getX: focus.body\getX
      getY: focus.body\getY
    }

    @x = -@focus.getX! + winW/2
    @y = -@focus.getY! + winW/2

  update: (dt)=>
    winW, winH = love.window.getMode!
    targetX = -@focus.getX! + winW/2
    targetY = -@focus.getY! + winH/2
    modifier = 5
    pad = 0
    drag = 10

    @x += (targetX - @x)/drag
    @y += (targetY - @y)/drag

  draw: =>
    love.graphics.translate @x, @y

  ignore: =>
    love.graphics.translate -@x, -@y

return
