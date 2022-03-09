PlayState = class {
    __includes = BaseState
}

function PlayState:init()
    self.paused = false
end

function PlayState:enter(params)
    self.paddle = params.paddle
    self.paddle.y = VIRTUAL_HEIGTH - 32
end

function PlayState:update(dt)
    if (love.keyboard.wasPressed('escape')) then
        love.event.quit()
    end

    if (love.keyboard.wasPressed('space')) then
        self.paused = not self.paused
    end

    if not self.paused then
        self.paddle:update(dt)
    end    
    
end

function PlayState:render()

    if self.paused then
        love.graphics.setFont(FONTS.l)
        love.graphics.printf('GAME PAUSED!', 0, VIRTUAL_HEIGTH / 2 - 32, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(FONTS.s)
        love.graphics.printf('(Press space to continue)', 0, VIRTUAL_HEIGTH / 2, VIRTUAL_WIDTH, 'center')
    end

    self.paddle:render()
end
