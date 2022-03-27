--[[ 
        Este codigo se encarga de agrupar las variables globales. 
--]]

TEXTURES = {
    ['bg'] =  love.graphics.newImage('assets/graphics/background.jpg'),
    ['tiles'] = love.graphics.newImage('assets/graphics/tiles.png')
}

FONTS = {
    ['s'] =  love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['m'] =  love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['l'] =  love.graphics.newFont('assets/fonts/font.ttf', 32),
    ['xl'] =  love.graphics.newFont('assets/fonts/font.ttf', 64)
}

SOUNDS = {
    ['swap'] = love.audio.newSource('assets/sounds/swap.wav', 'static')
}

TILE_COLORS = {}





for i = 1, 108 do
    TILE_COLORS[i] = love.graphics.newQuad( ((i - 1) * 32) % 384 , math.floor( (i - 1) / 12) * 32 , 32, 32, TEXTURES.tiles)
end
