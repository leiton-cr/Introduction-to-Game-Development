WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

push = require 'libraries/push'
class = require 'libraries/class'

require 'utils/Debug'


local scoreFont = love.graphics.newFont('assets/fonts/flappy.ttf', 64)
local images = {
    ['bg'] = love.graphics.newImage('assets/images/background.png'),
    ['ground'] = love.graphics.newImage('assets/images/ground.png')
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy')

    gameScore = 0

    debug = Debug()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGTH, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    if love.keyboard.isDown('space') then
       
    end
end

function love.draw()
    push:start()

    love.graphics.draw(images.bg, 0,0)
    love.graphics.draw(images.ground, 0,VIRTUAL_HEIGHT - 16)

    push:finish()

    displayScore()
    debug:displayFPS()
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.printf(
        'Score: ' .. gameScore,
        10,
        10,
        WINDOW_WIDTH,
        'left'
    )
end

function love.resize(w, h)
    push:resize(w, h)
end