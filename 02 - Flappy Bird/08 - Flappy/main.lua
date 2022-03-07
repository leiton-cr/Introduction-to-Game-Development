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

local scoreFont = love.graphics.newFont('assets/fonts/flappy.ttf', 64)
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

local bird = Bird()

local pipes = {}

local timer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

local scrolling = true

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

    if scrolling then

        timer = timer + dt

        scroll.bg = (scroll.bg + speed.bg * dt) % looping_point.bg

        scroll.ground = (scroll.ground + speed.ground * dt) % looping_point.bg

        if love.keyboard.isDown('space') then

        end

        if timer > 2 then

            local y = math.max(-PIPE_HEIGHT + 10,
                math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            lastY = y
            table.insert(pipes, PipePair(y))
            timer = 0
        end

        bird:update(dt)

        for k, pipes in pairs(pipes) do
            pipes:update(dt)

            if pipes.x + 32 < bird.x and pipes.pointed == false then
                bird.score = bird.score + 1
                pipes.pointed = true
            end

            for l, pipe in pairs(pipes.pipes) do
                if bird:collides(pipe) then
                    scrolling = false
                    
                end
            end


            if pipes.x < -64 then
                pipes.remove = true
            end
        end

        for k, pipes in pairs(pipes) do
            if pipes.remove then
                table.remove(pipes, k)
            end
        end

     


    end

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()

    love.graphics.draw(images.bg, -scroll.bg, 0)

    for k, v in pairs(pipes) do
        v:draw()
    end

    love.graphics.draw(images.ground, -scroll.ground, VIRTUAL_HEIGHT - 16)

    bird:draw()

    push:finish()

    displayScore()
    debug:displayFPS()
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.printf('Score: ' .. bird.score, 10, 10, WINDOW_WIDTH, 'left')
end

function love.resize(w, h)
    push:resize(w, h)
end
