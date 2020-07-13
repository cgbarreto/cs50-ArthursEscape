Score = Object:extend()

function Score:new()
    self.xPosition = 10
    self.yPosition = 10
    
    self.endPosition = love.graphics.getWidth() / 4

    -- Actual color
    r,g,b,a = love.graphics.getColor()

    -- Add a save and load
    if love.filesystem.getInfo("arthurRunBestScore.txt") then
        --self.bestScore = love.filesystem.read("arthurRunBestScore.txt")
        --self.bestScore = 0
        self.file = love.filesystem.read("arthurRunBestScore.txt")
        self.bestScore = lume.deserialize(self.file)
    else
        self.bestScore = 0
    end

    self.actualScore = 0

    self.newBestFlag = false
    self.endGame = false
end

function Score:update(dt)
    self.actualScore = self.actualScore + dt * 8
end

function Score:draw()
    love.graphics.setNewFont(20)
    love.graphics.print("Best Score: " .. math.floor(self.bestScore), self.xPosition, self.yPosition)
    love.graphics.print("Actual Score: " .. math.floor(self.actualScore), self.xPosition, self.yPosition + 30)

    if self.newBestFlag then
        love.graphics.setNewFont(55)
        love.graphics.setColor(22/255, 38/255, 46/255)
        love.graphics.print("New Best Score!!", self.endPosition, 200)
    end

    if self.endGame then    
        love.graphics.setNewFont(30)
        love.graphics.setColor(22/255, 38/255, 46/255)
        love.graphics.print("Press SPACE to play again", self.endPosition + 35, 300)
        love.graphics.setNewFont(20)
        love.graphics.setColor(r,g,b,a)
    end
end

function Score:bestUpdate()
    if self.actualScore > self.bestScore then
        self.bestScore = self.actualScore
        self.newBestFlag = true
        -- Save to file
        serialized = lume.serialize(self.bestScore)
        
        love.filesystem.write("arthurRunBestScore.txt", serialized)
    end
end

function Score:resetScore()
    if love.filesystem.getInfo("arthurRunBestScore.txt") then
        love.filesystem.remove("arthurRunBestScore.txt")
    else
        -- No score to delete
    end
    self.bestScore = 0
end