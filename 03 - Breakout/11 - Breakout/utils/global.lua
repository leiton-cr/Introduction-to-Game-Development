WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGTH = 288

--[[ Velocidad del paddle
     Hace que aumente la variable Delta X del paddle ]]
PADDLE_SPEED = 200

--[[ Friccion del paddle
     Hace que se deslice unos pixeles antes de detenerse por completo.]]
PADDLE_FRICTION = 0.90 

FONTS = {
    ['s'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['m'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['l'] = love.graphics.newFont('assets/fonts/font.ttf', 32),
    ['xl'] = love.graphics.newFont('assets/fonts/font.ttf', 64)
}

SOUNDS = {
    ['paddle_hit'] = love.audio.newSource('assets/sounds/paddle_hit.wav', 'static'),
    ['brick_hit_1'] = love.audio.newSource('assets/sounds/brick_hit_1.wav', 'static'),
    ['brick_hit_2'] = love.audio.newSource('assets/sounds/brick_hit_2.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('assets/sounds/wall_hit.wav', 'static'),
    ['hurt'] = love.audio.newSource('assets/sounds/hurt.wav', 'static'),
    ['recover'] = love.audio.newSource('assets/sounds/recover.wav', 'static'),

    ['music'] = love.audio.newSource('assets/sounds/music.wav', 'stream')
}

TEXTURES = {
    ['bg'] = love.graphics.newImage('assets/images/background.png'),

    ['breakout'] = love.graphics.newImage('assets/images/breakout.png'),
    ['arrows'] = love.graphics.newImage('assets/images/arrows.png'),
    ['particle'] = love.graphics.newImage('assets/images/particle.png')

}

HEALTH_QUAD = {
    ['full'] = love.graphics.newQuad(128,48,10,10,TEXTURES.breakout),
    ['empty'] = love.graphics.newQuad(138,48,10,10,TEXTURES.breakout)
}
