TitleState = class { __includes = BaseState}

local highlighted = 1

function TitleState:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        SOUNDS.paddle_hit:play()
    end 

end

function TitleState:render()
    love.graphics.setFont(FONTS.l)
    love.graphics.printf("Breakout", 0,VIRTUAL_HEIGTH / 3,VIRTUAL_WIDTH,'center');
    love.graphics.setFont(FONTS.m)
    
    if highlighted == 1 then
        love.graphics.setColor(0.40,1,1,1);
    end

    love.graphics.printf("START",0,VIRTUAL_HEIGTH/2 + 70, VIRTUAL_WIDTH,'center')
    
    love.graphics.setColor(1,1,1,1);

    if highlighted == 2 then
        love.graphics.setColor(0.40,1,1,1);
    end

    love.graphics.printf("HIGH SCORES",0,VIRTUAL_HEIGTH/2 + 90, VIRTUAL_WIDTH,'center')


end