ScoreState = class { __includes = BaseState }

local medals = {
    ['bronze'] = love.graphics.newImage('assets/images/bronze.png'),
    ['silver'] = love.graphics.newImage('assets/images/silver.png'),
    ['gold'] = love.graphics.newImage('assets/images/gold.png')
}

function ScoreState:enter(enterParameters)
    self.score = enterParameters.score

    self.awared = nil
end

function ScoreState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

    if self.score >= 12 then
        self.awared = medals.gold

    elseif  self.score >= 9  then
        self.awared = medals.silver

    elseif  self.score >= 6 then
        self.awared = medals.bronze

    else
        self.awared = nil        
    end

end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Points:' .. self.score, 0,64,VIRTUAL_WIDTH,'center')    

    love.graphics.setFont(meduimFont)
    love.graphics.printf('Press enter to restart', 0,100,VIRTUAL_WIDTH,'center')

    if self.awared then
        love.graphics.draw(self.awared,(VIRTUAL_WIDTH / 2) - 50, (VIRTUAL_HEIGHT / 2),0,0.2,0.2
    )
    end

end