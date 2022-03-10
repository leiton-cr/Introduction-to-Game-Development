PaddleSelectState = class { __includes = BaseState}

local leftArrowQuad = love.graphics.newQuad(0, 0, 24, 24, TEXTURES.arrows)
local rightArrowQuad = love.graphics.newQuad(24, 0, 24, 24, TEXTURES.arrows)

local highlighted = 1;

function PaddleSelectState:init()
    self.paddle = Paddle()
end


function PaddleSelectState:update(dt)

    if love.keyboard.wasPressed('left') then
        highlighted = 2
        self.paddle:previousSkin()
        SOUNDS.paddle_hit:play()
    end 

    if love.keyboard.wasPressed('right') then
        highlighted = 1
        self.paddle:nextSkin()
        SOUNDS.paddle_hit:play()
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    if love.keyboard.wasPressed('space') then
        gStateMachine:change('serve', {paddle = self.paddle})
    end

end

function PaddleSelectState:render()

    love.graphics.setFont(FONTS.m)
    love.graphics.printf("Select your paddle with left and right."  , 0,VIRTUAL_HEIGTH / 4,VIRTUAL_WIDTH,'center');
    love.graphics.setFont(FONTS.s)
    love.graphics.printf("(Press enter to continue)", 0,VIRTUAL_HEIGTH / 3,VIRTUAL_WIDTH,'center');

    if highlighted == 1 then
        love.graphics.setColor(1, 1, 1, 0.5)
    end

    love.graphics.draw(TEXTURES.arrows,leftArrowQuad,VIRTUAL_WIDTH/4 - 12,VIRTUAL_HEIGTH - VIRTUAL_HEIGTH /4)

    love.graphics.setColor(1, 1, 1, 1)
    if highlighted == 2 then
        love.graphics.setColor(1, 1, 1, 0.5)
    end

    love.graphics.draw(TEXTURES.arrows,rightArrowQuad,VIRTUAL_WIDTH / 2 + VIRTUAL_WIDTH/4 - 12, VIRTUAL_HEIGTH - VIRTUAL_HEIGTH /4)
    love.graphics.setColor(1, 1, 1, 1)

    self.paddle:render()

end