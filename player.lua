Player = Object:extend()

function Player:new()
    --self.image = love.graphics.newImage("graphics/adventurer/adventurer-idle-00.png")
    self.image = love.graphics.newImage("graphics/Adventurer/adventurer-v1.5-Sheet.png")
    self.imageWidth = self.image:getWidth()
    self.imageHeight = self.image:getHeight()
    
    self.framesMatrixX = 8 
    self.framesMatrixY = 16

    --self.width = self.imageWidth / self.framesMatrixX
    --self.height = self.imageHeight / self.framesMatrixY
    self.width = 50
    self.height = 37

    self.frames_run = {}

    self.scaleFactorX = 4
    self.scaleFactorY = 4

    self.x = 0
    self.y = love.graphics.getHeight() -  self.height * self.scaleFactorY - 65

    for i=2,self.framesMatrixX do
        --table.insert(self.frames_run, love.graphics.newQuad(i * self.width, 5 ,self.width,
                    --self.height, self.width * 8, self.height * 17))
        table.insert(self.frames_run, love.graphics.newQuad(self.width * i, self.height ,self.width,
                    self.height, self.imageWidth, self.imageHeight))                    
    end

    currentFrame = 1

end

function Player:update(dt)
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= #self.frames_run - 1 then
        currentFrame = 1
    end
end

function Player:draw()
    --love.graphics.draw(self.image, self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)
    love.graphics.print(self.width, 50, 50)
    love.graphics.print(self.height, 100, 50)
    love.graphics.print(#self.frames_run, 150, 50)
    love.graphics.draw(self.image, self.frames_run[math.floor(currentFrame)],self.x, self.y, 0, self.scaleFactorX, self.scaleFactorY)

end

