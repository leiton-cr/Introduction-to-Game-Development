VictoryState = class {__includes = BaseState}


function VictoryState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball or self.ball
    self.bricks = params.bricks 
    self.level = params.level + 1
    self.paddle.y = VIRTUAL_HEIGTH - 32

    self.ball.x = (self.paddle.x + self.paddle.width / 2) -4
    self.ball.y = self.paddle.y - 8
end


function VictoryState:update(dt)
    if (love.keyboard.wasPressed('escape')) then
        love.event.quit()
    end

    if (love.keyboard.wasPressed('space')) then
        gStateMachine:change('serve', {
            paddle = self.paddle,
            ball = self.ball,
            bricks = LevelMaker.createMap(self.level), 
            level = self.level
        })
    end

    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end
end

function VictoryState:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
        brick:renderParticles()
    end

    self.paddle:render()
    self.ball:render()

    love.graphics.setFont(FONTS.l)
    love.graphics.printf('VICTORY',0,VIRTUAL_HEIGTH /3 ,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(FONTS.m)
    love.graphics.printf('SCORE: ' .. self.paddle.score,0,VIRTUAL_HEIGTH /2 ,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(FONTS.s)
    love.graphics.printf('(Press space to continue)',0, VIRTUAL_HEIGTH /2 + 32 ,VIRTUAL_WIDTH,'center')

    renderHealth(self.paddle.health)
    renderScore(self.paddle.score)

end