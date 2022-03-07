PlayState = class { __includes = BaseState }

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.bird = Bird()
    self.pipes = {}
    self.timer = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.timer > 2 then

        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y
        table.insert(self.pipes, PipePair(y))
        self.timer = 0
    end

    self.bird:update(dt)

    for k, pipes in pairs(self.pipes) do
        pipes:update(dt)

        if pipes.x + 32 < self.bird.x and pipes.pointed == false then
            self.bird.score = self.bird.score + 1
            pipes.pointed = true
        end

        for l, pipe in pairs(pipes.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('title')
            end
        end

        if self.bird.y > VIRTUAL_HEIGHT or self.bird.y < -BIRD_HEIGHT  then
            gStateMachine:change('title')
        end



        if pipes.x < -64 then
            pipes.remove = true
        end
    end

    for k, pipes in pairs(self.pipes) do
        if pipes.remove then
            table.remove(pipes, k)
        end
    end
end

function PlayState:render()
    for k, v in pairs(self.pipes) do
        v:draw()
    end

    self.bird:draw()

    self:displayScore()

end

function PlayState:displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.printf('Score: ' .. self.bird.score, 10, 10, 
    VIRTUAL_WIDTH, 'left')
end