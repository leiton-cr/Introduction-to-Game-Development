OverState = class { __includes = BaseState }

function OverState:enter(params)
    self.score = params.score
end

function OverState:update(dt)
    if love.keyboard.wasPressed('space') then 
       
        if(self.score > gHighScores[10].score) then
            -- Es un highscore
            gStateMachine:change('enter_high_score', {score = self.score})
        else
            -- No es un highscore
            gStateMachine:change('high_scores')
        end
    end
end

function OverState:render()
    love.graphics.setFont(FONTS.l)
    love.graphics.printf('GAME OVER',0,VIRTUAL_HEIGTH /3 ,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(FONTS.m)
    love.graphics.printf('SCORE: ' .. self.score,0,VIRTUAL_HEIGTH /2 ,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(FONTS.s)
    love.graphics.printf('(Press space to continue)',0, VIRTUAL_HEIGTH - 24 ,VIRTUAL_WIDTH,'center')
end