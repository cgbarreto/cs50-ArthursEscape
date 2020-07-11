Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("graphics/adventurer/adventurer-idle-00.png")
    self.height = self.image:getHeight()
    self.x = 0
    self.y = love.graphics.getHeight() -  self.height * scaleFactorY - 10
    self.scaleFactorX = 3
    self.scaleFactory = 3
end

function Player:update(dt)

end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
end

