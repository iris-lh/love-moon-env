class Ground
  new: (options={x: 0, y: 0, w: 300, h: 50})=>
    @body = love.physics.newBody world, options.x, options.y
    @shape = love.physics.newRectangleShape options.w, options.h
    @fixture = love.physics.newFixture @body, @shape
    @id = utils.uuid!
    @name = @@__name
    @fixture\setUserData {name: @name, id: @id}

    @collisions = {}

  update: =>

  draw: =>
    love.graphics.setColor 72, 160, 14
    love.graphics.polygon 'fill', @body\getWorldPoints @shape\getPoints!



return
