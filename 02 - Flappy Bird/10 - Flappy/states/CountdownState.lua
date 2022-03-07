CountdownState = class { __includes = BaseState }

function CountdownState:init()
    self.timer = 3;
end

function CountdownState:update(dt)
    self.timer = self.timer - dt

    if self.timer <= 0 then
        gStateMachine:change('play')
    end
end

function CountdownState:render()
    love.graphics.setFont(scoreFont)
    love.graphics.printf(math.ceil(self.timer), 0,100,VIRTUAL_WIDTH,'center')
end