Object = require "classic"
push = require "push"
lume = require "lume"

defaultColor = {54/255, 56/255, 46/255, 255/255}

function love.load()

    require "background"
    require "player"
    require "enemy"
    require "score"
    
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

    love.graphics.setNewFont(20)
    score = Score()
    
    player = Player()
    enemy = Enemy()

end

function love.update(dt)

    if player.hit == 1 then
        score.endGame = true
        score:bestUpdate()
        if love.keyboard.isDown("space") then
            score.endGame = false
            --love.load()
            love.event.quit("restart")
        end
    else
        for i,v in ipairs(background) do
            v:update(dt)
        end
        player:update(dt,enemy)
        enemy:update(dt)
        score:update(dt)
    end

end

function love.draw()
    --love.graphics.clear(169/255, 146/255, 125/255, 255/255)
    love.graphics.clear(defaultColor)

    for i,v in ipairs(background) do
        v:draw()
    end

    player:draw()
    enemy:draw()
    score:draw()
end