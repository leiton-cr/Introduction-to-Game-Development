--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local medals = {
    ['bronze'] = love.graphics.newImage('medals/bronze.png'),
    ['silver'] = love.graphics.newImage('medals/silver.png'),
    ['gold'] = love.graphics.newImage('medals/gold.png')
}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    
    if self.score >= 15 then
        self.medal = medals.gold

    elseif  self.score >= 10  then
        self.medal = medals.silver

    elseif  self.score >= 5 then
        self.medal = medals.bronze

    else
        self.medal = nil        
    end

end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

    
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.medal then
        love.graphics.draw(self.medal,(VIRTUAL_WIDTH / 2) - 50, (VIRTUAL_HEIGHT / 2) - 20,0,0.2,0.2)
        love.graphics.printf('Press Enter to Play Again!', 0, VIRTUAL_HEIGHT - 40, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end