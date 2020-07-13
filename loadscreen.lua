LoadScreen = Object:extend()

function LoadScreen:new()
    -- Actual color
    r,g,b,a = love.graphics.getColor()
    self.windowWidth = love.graphics.getWidth()

    self.frontscreen = love.graphics.newImage("graphics/frontscreen.png")
    self.image = love.graphics.newImage("graphics/adventurer/adventurer-v1.5-Sheet.png")
    self.imageWidth = self.image:getWidth()
    self.imageHeight = self.image:getHeight()

    self.width = 50
    self.height = 37

    self.scaleFactorX = 3.7
    self.scaleFactorY = 3.7

    self.x = 0    
    self.y = love.graphics.getHeight() -  self.height * self.scaleFactorY - 15
    self.yInicial = self.y

    -- Idle setup
    self.framesIdle = {}

    -- Refatorar para guardar os frames com scaleFactor aplicado
    for i=1,4 do
        table.insert(self.framesIdle, love.graphics.newQuad(self.width * (i-1), 0 ,self.width,
                    self.height, self.imageWidth, self.imageHeight))                    
    end
    
    self.currentIdleFrame = 1
    self.buttomSelected = "NewGame"
    self.mode1 = "line"
    self.mode2 = "line"
    self.mode3 = "line"

    self.menuSpeed = 0
    self.dataAux = false
    self.showHist = false
    self.text = self:historyText()
end

function LoadScreen:update(dt)
    self.currentIdleFrame = self.currentIdleFrame + 0.23 * dt * deltaConst
    if self.currentIdleFrame >= #self.framesIdle then
        self.currentIdleFrame = 1
    end

    ------ Menu selection
    if love.keyboard.isDown("down") and self.menuSpeed == 0 then
        if self.buttomSelected == "NewGame" then
            self.buttomSelected = "ResetScore"
        elseif self.buttomSelected == "ResetScore" then
            self.buttomSelected = "Quit"
        end
        self.menuSpeed = 1
    end
    if love.keyboard.isDown("up") and self.menuSpeed == 0 then
        if self.buttomSelected == "ResetScore" then
            self.buttomSelected = "NewGame"
        elseif self.buttomSelected == "Quit" then
            self.buttomSelected = "ResetScore"
        end
        self.menuSpeed = 1
    end

    self.menuSpeed = self.menuSpeed - 6 * dt
    if self.menuSpeed < 0 then
        self.menuSpeed = 0
    end
end

function LoadScreen:draw()

    love.graphics.draw(self.frontscreen, self.windowWidth/6, 20, 0, 2, 2)
    love.graphics.setNewFont(35)
    love.graphics.setColor(22/255, 38/255, 46/255)

    if self.showHist then
        self:historyDraw()
    else
        self:menuDraw()
    end

    -- Refatorar para guardar os frames com scaleFactor aplicado
    love.graphics.draw(self.image, self.framesIdle[math.floor(self.currentIdleFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
end

-- Menu components
function LoadScreen:confirmReset()
    self.dataAux = true
end

function LoadScreen:menuDraw()
    -- Start new game button
    if self.buttomSelected == "NewGame" then
        self.mode1 = "fill"
        love.graphics.setColor(52/255, 68/255, 76/255)
    else
        self.mode1 = "line"
    end
    love.graphics.rectangle(self.mode1, 31 + self.windowWidth/4, 200, 95 + self.windowWidth/4, 40 )
    love.graphics.setColor(22/255, 38/255, 46/255)
    love.graphics.print("Start New Game", 35 + self.windowWidth/4, 200)

    -- See reset best Score button
    if self.buttomSelected == "ResetScore" then
        self.mode2 = "fill"
        love.graphics.setColor(52/255, 68/255, 76/255)
    else
        self.mode2 = "line"
    end
    love.graphics.rectangle(self.mode2, 31 + self.windowWidth/4, 250, 95 + self.windowWidth/4, 40 )
    love.graphics.setColor(22/255, 38/255, 46/255)
    love.graphics.print("Reset Best Score", 31 + self.windowWidth/4, 250)
    if self.dataAux then
        love.graphics.setNewFont(25)
        love.graphics.print("Reset Done", 31 + self.windowWidth/4 + 320, 255)
        love.graphics.setNewFont(35)
    end

    -- Quit game button
    if self.buttomSelected == "Quit" then
        self.mode3 = "fill"
        love.graphics.setColor(52/255, 68/255, 76/255)
    else
        self.mode3 = "line"
    end
    love.graphics.rectangle(self.mode3, 31 + self.windowWidth/4, 300, 95 + self.windowWidth/4, 40 )
    love.graphics.setColor(22/255, 38/255, 46/255)
    love.graphics.print("Quit Game", 85 + self.windowWidth/4, 300)

    love.graphics.setColor(r,g,b,a)

end


-- History components
function LoadScreen:confirmHistory()
    self.showHist = true
end

function LoadScreen:historyDraw()
    local fontSize = 15
    local rectOriginX = self.windowWidth/5
    local rectOriginY = self.windowWidth/6.5

    local textPositionY = 105

    love.graphics.setNewFont(fontSize)
    love.graphics.setColor(72/255, 88/255, 96/255)
    --love.graphics.rectangle("fill", rectOriginX, rectOriginY, 95 + self.windowWidth/2, 400)
    love.graphics.rectangle("fill", rectOriginX, rectOriginY, 95 + self.windowWidth/2, fontSize * 2.5 * #self.text + fontSize)

    love.graphics.setColor(22/255, 38/255, 46/255)
    
    for i = 1,#self.text do
        if i == 1 then
            love.graphics.print("Priest: " .. self.text[1], self.windowWidth/5 + fontSize, textPositionY + fontSize * 2 * i)
        else
            love.graphics.print("           " .. self.text[i], self.windowWidth/5 + fontSize, textPositionY + fontSize * 2 * i)
        end
    end
    love.graphics.setColor(235/255, 235/255, 46/255)
    love.graphics.print("Press SPACE to continue", self.windowWidth/2.5, fontSize * 3.3 * #self.text + fontSize)
    love.graphics.setColor(22/255, 38/255, 46/255)
    --love.graphics.print(self.text[1], self.windowWidth/5 + fontSize, 250)
    --love.graphics.print(self.text[2], 31 + self.windowWidth/4, 300)
end

function LoadScreen:historyText()
    local text = {
        "Wake up!",
        "It's late I know, but listen...",
        "The King... Ultrech is now gone...",
        "You're the hope... run Arthur as far as you can...",
        "You shall survive... you're the kingdom's future...",
        "They're here...",
        "RUN ARTHUR RUN!"
        }
    return text
end

