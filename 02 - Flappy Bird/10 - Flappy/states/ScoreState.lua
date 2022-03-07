ScoreState = class { __includes = BaseState }

function ScoreState:enter(enterParameters)
    self.score = enterParameters.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Points:' .. self.score, 0,64,VIRTUAL_WIDTH,'center')    

    love.graphics.setFont(meduimFont)
    love.graphics.printf('Press enter to restart', 0,100,VIRTUAL_WIDTH,'center')
end