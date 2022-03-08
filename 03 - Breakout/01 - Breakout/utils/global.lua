WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGTH = 288

FONTS = {
    ['s'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['m'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['l'] = love.graphics.newFont('assets/fonts/font.ttf', 32),
    ['xl'] = love.graphics.newFont('assets/fonts/font.ttf', 64)
}

SOUNDS = {
    ['paddle_hit'] = love.audio.newSource('assets/sounds/paddle_hit.wav', 'static')
}

TEXTURES = {
    ['bg'] = love.graphics.newImage('assets/images/background.png')
}
