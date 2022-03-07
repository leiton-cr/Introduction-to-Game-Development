WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

push = require 'libraries/push'
class = require 'libraries/class'

require 'utils/Debug'
require 'classes/Bird'

require 'classes/Pipe'
require 'classes/PipePair'

require 'classes/StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleState'


smallFont = love.graphics.newFont('assets/fonts/flappy.ttf', 8)
meduimFont = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
flappyFont = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
scoreFont = love.graphics.newFont('assets/fonts/flappy.ttf', 32)


local images = {
    ['bg'] = love.graphics.newImage('assets/images/background.png'),
    ['ground'] = love.graphics.newImage('assets/images/ground.png')
}

local sounds = {
    ['fly'] = love.audio.newSource('assets/sounds/jump.wav', 'static'),
    ['explosion'] = love.audio.newSource('assets/sounds/explosion.wav', 'static'),
    ['hurt'] = love.audio.newSource('assets/sounds/hurt.wav', 'static'),
    ['score'] = love.audio.newSource('assets/sounds/score.wav', 'static'),
    ['marios_way'] = love.audio.newSource('assets/sounds/marios_way.mp3', 'stream')
}

local scroll = {
    ['bg'] = 0,
    ['ground'] = 0
}

local speed = {
    ['bg'] = 30,
    ['ground'] = 60
}

local looping_point = {
    ['bg'] = 413,
    ['ground'] = 512
}

local timer = 0

local debug = Debug()

function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGTH, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
    }

    gStateMachine:change('title')

    love.keyboard.keysPressed = {}

end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)

    scroll.bg = (scroll.bg + speed.bg * dt) % looping_point.bg

    scroll.ground = (scroll.ground + speed.ground * dt) % looping_point.bg

    gStateMachine:update(dt)
    
    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()

    love.graphics.draw(images.bg, -scroll.bg, 0)

    gStateMachine:render()

    love.graphics.draw(images.ground, -scroll.ground, VIRTUAL_HEIGHT - 16)

    push:finish()

    debug:displayFPS()
end

function love.resize(w, h)
    push:resize(w, h)
end