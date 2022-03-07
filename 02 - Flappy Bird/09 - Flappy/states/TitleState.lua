TitleState = class {__includes = BaseState}


function TitleState:init()
    self.x = 1
end

function TitleState:update(dt)
    self.x = 2
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleState:render(dt)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy', 0,64,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(meduimFont)
    love.graphics.printf('Press enter', 0,100,VIRTUAL_WIDTH,'center')
end