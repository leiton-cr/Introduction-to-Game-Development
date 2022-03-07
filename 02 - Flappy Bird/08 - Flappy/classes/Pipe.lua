Pipe = class{}

local SPRITE = love.graphics.newImage('assets/images/pipe.png')
local DX = 30


PIPE_WIDTH = 70
PIPE_HEIGHT = 288

function Pipe:init(orientation, y)  

    self.orientation = orientation

    self.x = VIRTUAL_WIDTH
    self.y = y

    self.width =  SPRITE:getWidth()

    
end

function Pipe:update(x)
    self.x = x
end

function Pipe:draw()
    love.graphics.draw( SPRITE, self.x, 
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
        0, -- rotation
        1, -- X scale
        self.orientation == 'top' and -1 or 1 -- Y scale
    )
end