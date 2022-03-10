PlayState = class {
    __includes = BaseState
}

function PlayState:init()
    self.paused = false
    self.bricks = LevelMaker.createMap(0) 
end

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
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
        self.ball:update(dt)
    end    

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        SOUNDS.paddle_hit:play()
    end
    
    for k, brick in pairs(self.bricks) do
        if brick.tier > -1 and self.ball:collides(brick) then
            brick:hit()

            self.ball.y = self.ball.y - self.ball.dy * dt
            self.ball.dy = -self.ball.dy
            
        end
    end

end

function PlayState:render()
  
    self.ball:render()
    self.paddle:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    if self.paused then
        love.graphics.setFont(FONTS.l)
        love.graphics.printf('GAME PAUSED!', 0, VIRTUAL_HEIGTH / 2 - 32, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(FONTS.s)
        love.graphics.printf('(Press space to continue)', 0, VIRTUAL_HEIGTH / 2, VIRTUAL_WIDTH, 'center')
    end
end
