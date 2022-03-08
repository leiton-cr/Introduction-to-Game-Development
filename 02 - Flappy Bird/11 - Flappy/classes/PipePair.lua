PipePair = class{}

local GAP_HEIGHT = 90

local PIPE_SCROLL = -60

function PipePair:init(y)

    self.x = VIRTUAL_WIDTH + 32
    self.y = y

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bot', self.y + PIPE_HEIGHT + math.random(GAP_HEIGHT, GAP_HEIGHT+50))
    }
    self.remove = false
    self.pointed = false
end

function PipePair:update(dt)

    if self.x > -PIPE_WIDTH then
        self.x = self.x + PIPE_SCROLL * dt
        self.pipes.upper:update(self.x)
        self.pipes.lower:update(self.x)  
    else
        self.remove = true
    end

end

function PipePair:draw()
    for k, v in pairs(self.pipes) do
        v:draw()
    end
end