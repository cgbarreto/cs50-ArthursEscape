Player = Object:extend()

--default 25
deltaConst = 25

function Player:new()
    --self.image = love.graphics.newImage("graphics/adventurer/adventurer-idle-00.png")
    self.image = love.graphics.newImage("graphics/adventurer/adventurer-v1.5-Sheet.png")
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

    -- Run setup
    for i=2,self.framesMatrixX do
        table.insert(self.frames_run, love.graphics.newQuad(self.width * i, self.height ,self.width,
                    self.height, self.imageWidth, self.imageHeight))                    
    end


    -- Jump setup
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

    self.frames_slide = {}
    self.slideFlag = 0

    table.insert(self.frames_slide, love.graphics.newQuad(0, self.height, self.width,
                    self.height, self.imageWidth, self.imageHeight))    
    for i=3,6 do
        table.insert(self.frames_slide, love.graphics.newQuad(self.width * i, 3 * self.height, self.width,
                        self.height, self.imageWidth, self.imageHeight))    
    end
    table.insert(self.frames_slide, love.graphics.newQuad(0, 4 * self.height, self.width,
                    self.height, self.imageWidth, self.imageHeight))    

    self.currentFrame = 1
    self.currentJumpFrame = 1
    self.currentSlideFrame = 1

    self.hit = 0
    
    self.hitbox = {}
    self.hitbox.x = self.x + 70
    self.hitbox.y = self.y + 30
    self.hitbox.width = self.width * self.scaleFactorX - 110
    self.hitbox.height = self.height * self.scaleFactorY - 30

end

function Player:update(dt,obj)
    if self.y ~= self.yInicial then
        if self.currentJumpFrame >= #self.frames_jump then
            self.currentJumpFrame = #self.frames_jump
        else
            self.currentJumpFrame = self.currentJumpFrame + dt * 0.4 * deltaConst
        end
    elseif self.slideFlag  == 1 then
        self.currentSlideFrame = self.currentSlideFrame + dt * 0.5 * deltaConst
        if self.currentSlideFrame >= #self.frames_slide then
            self.currentSlideFrame = 1
            self.slideFlag  = 0
        end
    else
        self.currentFrame = self.currentFrame + 10 * dt
        if self.currentFrame >= #self.frames_run - 1 then
            self.currentFrame = 1
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
        self:applyGravity(dt)
    end

    if self.y < self.yInicial then
        self:applyGravity(dt)
    end

    -- Slide action
    if love.keyboard.isDown("down") and self.slideFlag ~= 1 then
        self.slideFlag  = 1
    end

    -- Hitbox update
    if self.slideFlag == 1 then
        self.hitbox = {}
        self.hitbox.x = self.x + 50
        self.hitbox.y = self.y + 65
        self.hitbox.width = self.width * self.scaleFactorX - 90
        self.hitbox.height = self.height * self.scaleFactorY - 65
    else
        self.hitbox = {}
        self.hitbox.x = self.x + 70
        self.hitbox.y = self.y + 30
        self.hitbox.width = self.width * self.scaleFactorX - 110
        self.hitbox.height = self.height * self.scaleFactorY - 30
    end


    if self:checkCollision(obj) then
        self.hit = 1
    else
        self.hit = 0
    end

end

function Player:draw()
    if self.y ~= self.yInicial then
        love.graphics.draw(self.image, self.frames_jump[math.floor(self.currentJumpFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
        --love.graphics.print("I wanna jump", 100, 100)

    elseif self.slideFlag == 1 then
        --love.graphics.print("Wanna slide", 100, 300)
        love.graphics.draw(self.image, self.frames_slide[math.floor(self.currentSlideFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    else
        love.graphics.draw(self.image, self.frames_run[math.floor(self.currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
        
    end
    
    if debug_player then
        love.graphics.setNewFont(15)
        if self.hit == 1 then
            love.graphics.print("HIT", 100, 50)
            self.mode = "fill"
        else
            self.mode = "line"
        end
        
        love.graphics.print("self.hit " .. self.hit, 100 , 100)
        love.graphics.print("self.y: " .. math.floor(self.y) .. "  self.yInicial: " .. self.yInicial, 100, 150)
        love.graphics.print("currentSlideFrame: " .. self.currentSlideFrame, 100, 250)
        love.graphics.print("self.jumpSpeed: " .. math.floor(self.jumpSpeed), 100, 200)

        ------ Study hit box
        r,g,b,a = love.graphics.getColor()
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line",self.x, self.y, self.width * self.scaleFactorX, self.height * self.scaleFactorY)
        --love.graphics.setColor(r,g,b,a)
        
        love.graphics.setColor(0,1,0)
        --love.graphics.rectangle(self.mode,self.x + 70, self.y + 30, self.width * self.scaleFactorX - 110, self.height * self.scaleFactorY - 30)
        love.graphics.rectangle(self.mode, self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
        love.graphics.setColor(r,g,b,a)

        --Slide hitbox
        if self.slideFlag == 1 then
            love.graphics.setColor(0,0,1)
            love.graphics.rectangle("line",self.x + 50, self.y + 65, self.width * self.scaleFactorX - 90, self.height * self.scaleFactorY - 65)
            love.graphics.setColor(r,g,b,a)
        end
    end

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

function Player:checkCollision(obj)
    local a_left = self.hitbox.x
    local a_right = self.hitbox.x + self.hitbox.width
    local a_top = self.hitbox.y
    local a_bottom = self.hitbox.y + self.hitbox.height

    local obj_left = obj.hitbox.x
    local obj_right = obj.hitbox.x + obj.hitbox.width
    local obj_top = obj.hitbox.y
    local obj_bottom = obj.hitbox.y + obj.hitbox.height

    if a_right > obj_left and
        a_left < obj_right and
        a_bottom > obj_top and
        a_top < obj_bottom then

        return true
    else
        return false
    end

end

function Player:loadScreen()
    love.graphics.draw(self.image, self.framesIdle[math.floor(self.currentIdleFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
end

function Player:updateloadScreen(dt)
    self.currentIdleFrame = self.currentIdleFrame + 0.28 * dt * deltaConst
    if self.currentIdleFrame >= #self.framesIdle then
        self.currentIdleFrame = 1
    end
end