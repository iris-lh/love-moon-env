class Player
  new: (options={x: 0, y: 0, r: 40})=>
    @body = love.physics.newBody world, options.x, options.y, 'dynamic'
    @shape = love.physics.newCircleShape options.r
    -- @shape = love.physics.newRectangleShape 40, 40
    @fixture = love.physics.newFixture @body, @shape, 1
    @fixture\setRestitution 0.2
    @id = utils.uuid!
    @name = @@__name
    @fixture\setUserData {name: @@__name, id: @id}

    @collisions = {}

  update: =>



  draw: =>
    love.graphics.setColor 193, 47, 14 --set the drawing color to red for the player
    love.graphics.circle 'fill', @body\getX!, @body\getY!, @shape\getRadius!
    -- love.graphics.polygon 'fill', @body\getWorldPoints @shape\getPoints!



return
