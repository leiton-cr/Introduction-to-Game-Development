ServeState = class {__includes = BaseState }

function ServeState:init()
    self.ball = Ball()
    self.level = 1
    self.bricks = LevelMaker.createMap(0)
 end
 

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks or self.bricks 
    self.ball = params.ball or self.ball
    self.level = params.level or 1
    self.paddle.y = VIRTUAL_HEIGTH - 32
end

function ServeState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('paddle_select')
    end

    if (love.keyboard.wasPressed('space')) then
        gStateMachine:change('play', { 
            paddle = self.paddle, 
            ball = self.ball,
            bricks = self.bricks,
            level = self.level
        })
    end

    self.paddle:update(dt)

    self.ball.x = (self.paddle.x + self.paddle.width / 2) -4
    self.ball.y = self.paddle.y - 8

end

function ServeState:render()
    renderHealth(self.paddle.health)
    renderScore(self.paddle.score)
    
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    love.graphics.setFont(FONTS.l)
    love.graphics.printf("Level: " .. self.level  , 0,VIRTUAL_HEIGTH / 2,VIRTUAL_WIDTH,'center');
    love.graphics.setFont(FONTS.s)
    love.graphics.printf("(Press space to serve)", 0,VIRTUAL_HEIGTH / 2 + 32,VIRTUAL_WIDTH,'center');

    self.ball:render()
    self.paddle:render()
end

