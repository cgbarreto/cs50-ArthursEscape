Player = Object:extend()

deltaConst = 25

function Player:new()
    --self.image = love.graphics.newImage("graphics/adventurer/adventurer-idle-00.png")
    self.image = love.graphics.newImage("graphics/Adventurer/adventurer-v1.5-Sheet.png")
    self.imageWidth = self.image:getWidth()
    self.imageHeight = self.image:getHeight()
    
    self.framesMatrixX = 8 
    self.framesMatrixY = 16

    self.width = 50
    self.height = 37

    self.frames_run = {}

    self.scaleFactorX = 3.7
    self.scaleFactorY = 3.7

    self.x = 0    
    self.y = love.graphics.getHeight() -  self.height * self.scaleFactorY - 15
    self.yInicial = self.y

    for i=2,self.framesMatrixX do
        table.insert(self.frames_run, love.graphics.newQuad(self.width * i, self.height ,self.width,
                    self.height, self.imageWidth, self.imageHeight))                    
    end

    self.frames_jump = {}

    for i=1,5 do
        table.insert(self.frames_jump, love.graphics.newQuad(self.width * (i-1), 2 * self.height ,self.width,
    self.height, self.imageWidth, self.imageHeight))    
    end
    for i=1,1 do
        table.insert(self.frames_jump, love.graphics.newQuad(self.width * i, 3 * self.height ,self.width,
                    self.height, self.imageWidth, self.imageHeight))    
    end

    self.jumpFlag = 0
    self.jumpHigh = -self.width
    self.jumpSpeed = 0
    self.gravity = 5

    currentFrame = 1
    currentJumpFrame = 1

end

function Player:update(dt)
    
    if self.y ~= self.yInicial then
        if currentJumpFrame >= #self.frames_jump then
            currentJumpFrame = #self.frames_jump
        else
            currentJumpFrame = currentJumpFrame + dt * 0.4 * deltaConst
        end
    else
        currentFrame = currentFrame + 10 * dt
        if currentFrame >= #self.frames_run - 1 then
            currentFrame = 1
        end
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + 200 * dt
    end

    local windowWidth = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0
    elseif self.x > windowWidth - 3 * self.width then
        self.x = windowWidth - 3 * self.width
    end
    

    -- Jump action
    if love.keyboard.isDown("up") and self.jumpFlag == 0 then
        self.jumpSpeed = self.jumpHigh
        self.jumpFlag = 1
        love.graphics.print("I wanna jump", 100, 100)
        self:applyGravity(dt)
    end

    if self.y < self.yInicial then
        self:applyGravity(dt)
    end
end

function Player:draw()
    if self.y ~= self.yInicial then
        love.graphics.draw(self.image, self.frames_jump[math.floor(currentJumpFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
        --love.graphics.print("I wanna jump", 100, 100)
    else
        love.graphics.draw(self.image, self.frames_run[math.floor(currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
        
    end
    
    love.graphics.print("self.y: " .. math.floor(self.y) .. "  self.yInicial: " .. self.yInicial, 100, 150)
    love.graphics.print("currentJumpFrame: " .. currentJumpFrame, 100, 250)
    love.graphics.print("self.jumpSpeed: " .. math.floor(self.jumpSpeed), 100, 200)

    -- Study hit box
    r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",self.x, self.y, self.width * self.scaleFactorX, self.height * self.scaleFactorY)
    --love.graphics.setColor(r,g,b,a)
    
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("line",self.x + 70, self.y + 30, self.width * self.scaleFactorX - 110, self.height * self.scaleFactorY - 30)
    love.graphics.setColor(r,g,b,a)
    ---
end

function Player:applyGravity(dt)
    self.y = self.y + self.jumpSpeed * dt * deltaConst
    self.jumpSpeed = self.jumpSpeed + self.gravity * dt * deltaConst
 
    if self.y >= self.yInicial then
        self.y = self.yInicial
        self.jumpSpeed = 0
        self.jumpFlag = 0
        currentJumpFrame = 1
    end
end
