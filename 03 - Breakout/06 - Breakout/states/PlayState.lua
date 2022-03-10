PlayState = class {
    __includes = BaseState
}

function PlayState:init()
    self.paused = false
end

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.bricks = params.bricks
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

        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = 50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))

        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = -50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

        self.ball.dy = -self.ball.dy
        SOUNDS.paddle_hit:play()

    end

    for k, brick in pairs(self.bricks) do
        if brick.tier > -1 and self.ball:collides(brick) then
            brick:hit() 
            self.paddle.score = self.paddle.score + 10

            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = self.ball.x - 2

            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = self.ball.x + 2

            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = self.ball.y - 2

            else
                self.ball.dy = -self.ball.dy
                self.ball.y = self.ball.y + 2

            end

            self.ball.dy = self.ball.dy * 1.02
            self.ball.y = self.ball.y + (self.ball.dy * dt)

        end
    end

    if self.ball.y > VIRTUAL_HEIGTH + 8 then
        self.paddle:healthDown()

        if self.paddle.health > 0 then
            gStateMachine:change('serve', {
                paddle = self.paddle,
                ball = self.ball,
                bricks = self.bricks
            })
        else
            gStateMachine:change('game_over', {
                score = self.paddle.score
            })
        end

    end

end

function PlayState:render()
    renderHealth(self.paddle.health)
    renderScore(self.paddle.score)
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
