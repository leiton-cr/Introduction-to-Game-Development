WINDOW_WIDTH = 1280
WINDOW_HEIGTH = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

push = require 'libraries/push'
class = require 'libraries/class'

require 'utils/Debug'
require 'classes/Bird'
require 'classes/Pipe'

local scoreFont = love.graphics.newFont('assets/fonts/flappy.ttf', 64)
local images = {
    ['bg'] = love.graphics.newImage('assets/images/background.png'),
    ['ground'] = love.graphics.newImage('assets/images/ground.png')
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

local bird = Bird()

local pipes = {}

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
    timer = timer + dt

    scroll.bg = (scroll.bg + speed.bg * dt) % looping_point.bg

    scroll.ground = (scroll.ground + speed.ground * dt) % looping_point.bg

    if not love.keyboard.isDown('space') then
      
    end


    if timer > 2 then
        table.insert(pipes, Pipe())
        timer = 0
    end

    bird:update(dt)

    for k, v in pairs(pipes) do
        v:update(dt)

        if v.x < -v.width then
            table.remove(pipes, k)
        end
    end
   

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()

    love.graphics.draw(images.bg, -scroll.bg,0)
   
    for k, v in pairs(pipes) do
        v:draw()
    end

    love.graphics.draw(images.ground, -scroll.ground,VIRTUAL_HEIGHT - 16)

    bird:draw()


    push:finish()

    displayScore()
    debug:displayFPS()
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.printf(
        'Score: ' .. bird.score .. ' ' .. timer,
        10,
        10,
        WINDOW_WIDTH,
        'left'
    )
end

function love.resize(w, h)
    push:resize(w, h)
end