Object = require "classic"
push = require "push"

defaultColor = {54/255, 56/255, 46/255, 255/255}

function love.load()

    require "background"
    require "player"
    require "enemy"
    
    bgLayer = {
        love.graphics.newImage("graphics/background/plx-1.png"),
        love.graphics.newImage("graphics/background/plx-2.png"),
        love.graphics.newImage("graphics/background/plx-3.png"),
        love.graphics.newImage("graphics/background/plx-4.png"),
        love.graphics.newImage("graphics/background/plx-5.png")
    }

    local scaleFactorX = 2.1
    local scaleFactorY = 3

    background = {}
    for i=1,#bgLayer do
        table.insert(background, Background(bgLayer[i], 15 * (i), scaleFactorX, scaleFactorY))
    end

    player = Player()

    enemy_img1 = love.graphics.newImage("graphics/enemies/hell-hound-run.png")
    enemy = Enemy(enemy_img1)

end

function love.update(dt)
    for i,v in ipairs(background) do
        v:update(dt)
    end
    player:update(dt)
    --enemy:update(dt)
end

function love.draw()
    --love.graphics.clear(169/255, 146/255, 125/255, 255/255)
    love.graphics.clear(defaultColor)

    for i,v in ipairs(background) do
        v:draw()
    end

    player:draw()
    --enemy:draw()
end