class Block
  new: (options={x: 0, y: 0, w: 50, h: 50})=>
    @body = love.physics.newBody world, options.x, options.y, 'dynamic'
    @shape = love.physics.newRectangleShape 0, 0, options.w, options.h
    @fixture = love.physics.newFixture @body, @shape, 5
    @id = utils.uuid!
    @name = @@__name
    @fixture\setUserData @id
    @fixture\setUserData {name: @@__name, id: @id}

    @collisions = {}

  update: =>

  draw: =>
    love.graphics.setColor 50, 50, 50
    love.graphics.polygon 'fill', @body\getWorldPoints @shape\getPoints!



return
