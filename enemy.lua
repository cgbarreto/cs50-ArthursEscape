Enemy = Object:extend()

function Enemy:new(image)
    self.image = image
    self.imageWidth = image:getWidth()
    self.imageHeight = image:getHeight()
    self.scaleFactorY = 1

    self.width = 67
    self.height = 32

    self.x = 350
    self.y = love.graphics.getHeight() -  self.imageHeight * self.scaleFactorY - 15

    self.frames = {}

    for i=1,5 do
        table.insert(self.frames, love.graphics.newQuad(i * self.width, self.height ,self.width,
        self.height, self.imageWidth, self.imageHeight))                        
    end

    currentFrame = 1
end

function Enemy:update(dt)
    --currentFrame = currentFrame + 10 * dt
    --if currentFrame >= #self.frames then
    --    currentFrame = 1
    --end
end

function Enemy:draw()
    
    --love.graphics.draw(self.image, self.frames[math.floor(currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    love.graphics.draw(self.image, self.frames[math.floor(currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
end

