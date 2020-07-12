Background = Object:extend()

function Background:new(image, slideSpeed, scaleFactorX, scaleFactorY)
    self.image = image
    self.width = love.graphics.getWidth()
    self.slideSpeed = slideSpeed
    self.scaleFactorX = scaleFactorX
    self.scaleFactorY = scaleFactorY

    self.x1 = 0
    self.x2 = self.width
end

function Background:update(dt)
    self.x1 = self.x1 - self.slideSpeed * dt
    self.x2 = self.x2 - self.slideSpeed * dt

    if self.x1 < - self.width then
        self.x1 = self.width
    end

    if self.x2 < - self.width then
        self.x2 = self.width
    end

end

function Background:draw()
    love.graphics.draw(self.image, self.x1, 0, 0, self.scaleFactorX, self.scaleFactorY)
    love.graphics.draw(self.image, self.x2, 0, 0, self.scaleFactorX, self.scaleFactorY)
end

