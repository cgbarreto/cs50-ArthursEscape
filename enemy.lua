Enemy = Object:extend()

function Enemy:new(image)
    --self.image = image

    self.image = love.graphics.newImage("graphics/enemies/blur_hell-hound-run.png")
    self.imageJump = love.graphics.newImage("graphics/enemies/blur_hell-hound-jump.png")
    self.imageWidth = self.image:getWidth()
    self.imageHeight = self.image:getHeight()
    self.scaleFactorX = 2.3
    self.scaleFactorY = 2.3

    self.width = 67
    self.height = 32

    self.x = love.graphics.getWidth() + 30
    self.xInicial = self.x
    self.y = love.graphics.getHeight() - self.imageHeight * self.scaleFactorY - 15
    self.yInicial = self.y

    self.runSpeed = 300

    self.frames = {}

    for i=1,5 do
        table.insert(self.frames, love.graphics.newQuad((i-1) * self.width, 0 ,self.width,
        self.height, self.imageWidth, self.imageHeight))                        
    end

    self.framesJump = {}

    self.scaleFactorXJump = 3
    self.scaleFactorYJump = 3

    self.widthJump = 56
    self.heightJump = 32

    self.jumpFlag = false
    self.jumpBlock = 0.9

    self.jumpHigh = -self.width
    self.jumpSpeed = 0
    self.gravity = 7

    for i=1,6 do
        table.insert(self.framesJump, love.graphics.newQuad((i-1) * self.widthJump, 0 ,self.widthJump,
        self.heightJump, self.imageWidth, self.imageHeight))                        
    end

    self.currentFrame = 1
    self.currentJumpFrame  = 1

    self.hitbox = {}
    self.hitbox.x = self.x + self.width/2
    self.hitbox.y = self.y + self.height/2.7
    self.hitbox.width = self.width * self.scaleFactorX - self.width/1.5
    self.hitbox.height = self.height * self.scaleFactorY - self.height/2.5
end

function Enemy:update(dt)
    
    if self.jumpFlag then
        self.currentJumpFrame = self.currentJumpFrame + 6 * dt
        if self.currentJumpFrame >= #self.framesJump then
            self.currentJumpFrame = 1
            self.jumpFlag = false
            self.currentFrame = 1
        end
    else
        self.currentFrame = self.currentFrame + 10 * dt
        if self.currentFrame >= #self.frames then
            self.currentFrame = 1
        end
    end

    -- Jump flag control
    if not self.jumpFlag and self.jumpBlock == 0 then
        self:jump()
        self.jumpSpeed = self.jumpHigh
        self.jumpBlock = 1
        self:applyGravity(dt)
    end

    if self.jumpBlock ~= 0 then
        self.jumpBlock = self.jumpBlock - dt * 0.5
        if self.jumpBlock <= 0 then
            self.jumpBlock = 0
        end
    end

    if self.y < self.yInicial then
        self:applyGravity(dt)
    end

    -- X movement
    self.x = self.x - self.runSpeed * dt
    if self.x < -2 * self.width then
        self.x = self.xInicial
    end

    -- Hitbox update
    self.hitbox.x = self.x + self.width/2
    self.hitbox.y = self.y + self.height/2.7
    self.hitbox.width = self.width * self.scaleFactorX - self.width/1.5
    self.hitbox.height = self.height * self.scaleFactorY - self.height/2.5

end

function Enemy:draw()
    
    if self.jumpFlag then
        love.graphics.draw(self.imageJump, self.framesJump[math.floor(self.currentJumpFrame)],self.x, self.y, 0, self.scaleFactorXJump, self.scaleFactorYJump)
    else
        love.graphics.draw(self.image, self.frames[math.floor(self.currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    end

    if debug_enemy then
        love.graphics.setNewFont(15) 
        love.graphics.print("self.y: " .. math.floor(self.y) .. "  self.yInicial: " .. self.yInicial, 400, 150)
        love.graphics.print("Run Frame: " .. math.floor(self.currentFrame) .. 
                            "  Jump Frame:" .. math.floor(self.currentJumpFrame), 400, 250)
        love.graphics.print("self.jumpBlock: " .. self.jumpBlock, 400, 300)

        ------ Study hit box
        r,g,b,a = love.graphics.getColor()
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line",self.x, self.y, self.width * self.scaleFactorX, self.height * self.scaleFactorY)
        --love.graphics.setColor(r,g,b,a)
        
        love.graphics.setColor(0,1,0)
        --love.graphics.rectangle("line", self.x + self.width/2, self.y + self.height/2.7, 
                                --self.width * self.scaleFactorX - self.width/1.5, self.height * self.scaleFactorY - self.height/2.5)
        love.graphics.rectangle("line", self.hitbox.x, self.hitbox.y, 
                                self.hitbox.width, self.hitbox.height)
        love.graphics.setColor(r,g,b,a)

    end
end

function Enemy:jump()
    self.jumpFlag = true
end

function Enemy:applyGravity(dt)
    self.y = self.y + self.jumpSpeed * dt * deltaConst
    self.jumpSpeed = self.jumpSpeed + self.gravity * dt * deltaConst
 
    if self.y >= self.yInicial then
        self.y = self.yInicial
        self.jumpSpeed = 0
        self.jumpFlag = 0
        currentJumpFrame = 1
    end
end