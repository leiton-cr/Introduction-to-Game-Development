CountdownState = class { __includes = BaseState }

function CountdownState:init()
    self.seconds = 3
    self.timer = 0;
end

function CountdownState:update(dt)
    self.timer = self.timer + dt
   
    if(self.timer > 0.75) then
        self.timer = 0
        self.seconds = self.seconds -1 
    end

    if self.seconds == 0 then
        gStateMachine:change('play')
    end
end

function CountdownState:render()
    love.graphics.setFont(scoreFont)
    love.graphics.printf(self.seconds, 0,100,VIRTUAL_WIDTH,'center')
end