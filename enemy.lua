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
    self.jumpFlag = false
    for i=1,5 do
        table.insert(self.framesJump, love.graphics.newQuad((i-1) * self.width, 0 ,self.width,
        self.height, self.imageWidth, self.imageHeight))                        
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
    
    if not self.jumpFlag then
        self.currentFrame = self.currentFrame + 10 * dt
        if self.currentFrame >= #self.frames then
            self.currentFrame = 1
        end
    else
        self.currentJumpFrame = self.currentJumpFrame + 10 * dt
        if self.currentJumpFrame >= #self.framesJump then
            self.currentJumpFrame = 1
            self.jumpFlag = false
            self.currentFrame = 1
        end

    end

    self.x = self.x - self.runSpeed * dt
    if self.x < -2 * self.width then
        self.x = self.xInicial
    end

    -- Hitbox update
    self.hitbox.x = self.x + self.width/2
    self.hitbox.y = self.y + self.height/2.7
    self.hitbox.width = self.width * self.scaleFactorX - self.width/1.5
    self.hitbox.height = self.height * self.scaleFactorY - self.height/2.5

    if love.math.random(0,1) > 0.95 and not self.jumpFlag then
        self.jumpFlag = true
    end


end

function Enemy:draw()
    
    if not self.jumpFlag then
        love.graphics.draw(self.image, self.frames[math.floor(self.currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    else
        love.graphics.draw(self.image, self.framesJump[math.floor(self.currentJumpFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    end


    if debug_enemy then
        love.graphics.setNewFont(15) 
        love.graphics.print("self.y: " .. math.floor(self.y) .. "  self.yInicial: " .. self.yInicial, 400, 150)
        love.graphics.print("self.currentFrame: " .. self.currentFrame, 400, 250)
        --love.graphics.print("self.jumpSpeed: " .. math.floor(self.jumpSpeed), 100, 200)

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

        --Slide hitbox
        --if self.slideFlag == 1 then
        --    love.graphics.setColor(0,0,1)
        --    love.graphics.rectangle("line",self.x + 50, self.y + 65, self.width * self.scaleFactorX - 90, self.height * self.scaleFactorY - 65)
        --   love.graphics.setColor(r,g,b,a)
        --end
    end
end

