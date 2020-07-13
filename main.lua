Object = require "classic"
push = require "push"
lume = require "lume"

debug_player = false
debug_enemy = false

flagLoadScreen = true

defaultColor = {54/255, 56/255, 46/255, 255/255}

function love.load()

    require "preload"
    require "background"
    require "loadscreen"

    background = {}
    for i=1,#bgLayer do
        table.insert(background, Background(bgLayer[i], 15 * (i), bgLayer.scaleFactorX, bgLayer.scaleFactorY))
    end
    loadScreen = LoadScreen()

    require "player"
    require "enemy"
    require "score"

    love.graphics.setNewFont(20)
    score = Score()   
    player = Player()
    enemy = Enemy()

end

function love.update(dt)

    if flagLoadScreen then
        loadScreen:update(dt)
        if love.keyboard.isDown("return") then
            if loadScreen.buttomSelected == "NewGame" then
                flagLoadScreen = false
            elseif loadScreen.buttomSelected == "ResetScore" then
                score:resetScore()
            elseif loadScreen.buttomSelected == "Quit" then
                love.event.quit()
            end
        end
    else
        if player.hit == 1 then
            score.endGame = true
            score:bestUpdate()
            if love.keyboard.isDown("space") then
                score.endGame = false
                love.load()
            end
        else
            for i,v in ipairs(background) do
                v:update(dt)
            end
            score:update(dt)
            player:update(dt,enemy)
            enemy:update(dt)

        end
    end

end

function love.draw()
    --love.graphics.clear(169/255, 146/255, 125/255, 255/255)
    love.graphics.clear(defaultColor)

    for i,v in ipairs(background) do
        v:draw()
    end

    if not flagLoadScreen then
        player:draw()
        enemy:draw()
        score:draw()
    else
        loadScreen:draw()
    end
end