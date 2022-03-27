--[[
        Pause sate save the actual values of the game and when 
        the player unpause the game start using the same values.
]]
PauseState = Class{__includes = BaseState}

--[[
        When enter to this state the game save the actual values
]]
function PauseState:enter(params) 
    self.savedParams = params
    paused = true

    sounds['music']:pause()
end

--[[
       The only input available when paused is to press p to resume.
]]
function PauseState:update(dt)
    if love.keyboard.wasPressed("p") then
        sounds['pause']:play()
        gStateMachine:change('countdown', self.savedParams)
    end
end

--[[
        Render on screen the static values.
]]
function PauseState:render()

    for k, pair in pairs(self.savedParams.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.savedParams.score), 8, 8)

    self.savedParams.bird:render()

    love.graphics.setFont(hugeFont)
    love.graphics.printf("PAUSE", 0, 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    love.graphics.printf("Press P to continue", 0, 180, VIRTUAL_WIDTH, 'center')
end