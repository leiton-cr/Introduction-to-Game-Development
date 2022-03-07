Pipe = class{}

local SPRITE = love.graphics.newImage('assets/images/pipe.png')
local DX = 30

local PIPE_SCROLL = -60

function Pipe:init()  
    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

    self.width =  SPRITE:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:draw()
    love.graphics.draw(SPRITE, self.x, self.y)
end