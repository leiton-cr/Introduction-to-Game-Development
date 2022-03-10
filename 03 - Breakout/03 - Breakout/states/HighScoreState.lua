HighScoreState = class {__includes = BaseState}


function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end    
end

function HighScoreState:render()
    love.graphics.setFont(FONTS.l)
    love.graphics.printf("HIGH SCORES."  , 0, 24,VIRTUAL_WIDTH,'center');

    love.graphics.setFont(FONTS.s)
    love.graphics.printf("Press escape to return."  , 0, VIRTUAL_HEIGTH - 24,VIRTUAL_WIDTH,'center');
end