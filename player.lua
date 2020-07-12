Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("graphics/adventurer/adventurer-idle-00.png")
    self.height = self.image:getHeight()
    
    self.scaleFactorX = 3
    self.scaleFactorY = 3

    self.x = 0
    self.y = love.graphics.getHeight() -  self.height * self.scaleFactorY - 10
end

function Player:update(dt)

end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
end

