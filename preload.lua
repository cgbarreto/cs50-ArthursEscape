bgLayer = {
    love.graphics.newImage("graphics/background/plx-1.png"),
    love.graphics.newImage("graphics/background/plx-2.png"),
    love.graphics.newImage("graphics/background/plx-3.png"),
    love.graphics.newImage("graphics/background/plx-4.png"),
    love.graphics.newImage("graphics/background/plx-5.png"),
    scaleFactorX = 2.1,
    scaleFactorY = 3
}

song = love.audio.newSource("sound/song.mp3", "stream")

hithurt = love.audio.newSource("sound/Hit_Hurt.wav", "static")