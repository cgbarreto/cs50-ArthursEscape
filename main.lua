
Object = require "classic"

push = require "push"



function love.load()
    bgLayer1 = love.graphics.newImage('graphics/background/plx-1.png')
    bgLayer2 = love.graphics.newImage('graphics/background/plx-2.png')
    bgLayer3 = love.graphics.newImage('graphics/background/plx-3.png')
    bgLayer4 = love.graphics.newImage('graphics/background/plx-4.png')
    bgLayer5 = love.graphics.newImage('graphics/background/plx-5.png')

    scaleFactorX = 2.1
    scaleFactorY = 3

    require "player"
    player = Player()

end

function love.update(dt)

end

function love.draw()
    love.graphics.clear(108/255, 140/255, 255/255, 255/255)
    love.graphics.draw(bgLayer1,0, 0, 0, scaleFactorX, scaleFactorY)
    love.graphics.draw(bgLayer2,0, 0, 0, scaleFactorX, scaleFactorY)
    love.graphics.draw(bgLayer3,0, 0, 0, scaleFactorX, scaleFactorY)
    love.graphics.draw(bgLayer4,0, 0, 0, scaleFactorX, scaleFactorY)
    love.graphics.draw(bgLayer5,0, 0, 0, scaleFactorX, scaleFactorY)
    love.graphics.print(love.graphics.getWidth() .. " " .. " " .. love.graphics.getHeight())
    love.graphics.print(bgLayer1:getWidth() .. " " .. " " .. bgLayer1:getHeight(),0,50)

    player:draw()
end