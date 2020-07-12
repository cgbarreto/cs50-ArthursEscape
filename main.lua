Object = require "classic"
push = require "push"

function love.load()
    require "background"
    require "player"
    
    bgLayer = {
        love.graphics.newImage('graphics/background/plx-1.png'),
        love.graphics.newImage('graphics/background/plx-2.png'),
        love.graphics.newImage('graphics/background/plx-3.png'),
        love.graphics.newImage('graphics/background/plx-4.png'),
        love.graphics.newImage('graphics/background/plx-5.png')
    }

    local scaleFactorX = 2.1
    local scaleFactorY = 3

    background = {}
    --background = Background(bgLayer1, 10, scaleFactorX, scaleFactorY)
    for i=1,#bgLayer do
        table.insert(background, Background(bgLayer[i], 15 * (i), scaleFactorX, scaleFactorY))
    end

    player = Player()

end

function love.update(dt)
    --background:update(dt)
    for i,v in ipairs(background) do
        v:update(dt)
    end
    player:update(dt)
end

function love.draw()
    --love.graphics.clear(169/255, 146/255, 125/255, 255/255)
    love.graphics.clear(54/255, 56/255, 46/255, 255/255)

    --background:draw()
    for i,v in ipairs(background) do
        v:draw()
    end

    player:draw()
end