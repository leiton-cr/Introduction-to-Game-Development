ServeState = class {__includes = BaseState }

function ServeState:enter(params)
    self.paddle = params.paddle
    self.paddle.y = VIRTUAL_HEIGTH - 32
end

function ServeState:init()
   self.ball = Ball()
end

function ServeState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('paddle_select')
    end

    if (love.keyboard.wasPressed('space')) then
        gStateMachine:change('play', { paddle = self.paddle, ball = self.ball})
    end

    self.paddle:update(dt)

    self.ball.x = self.paddle.x + self.paddle.width / 2
    self.ball.y = self.paddle.y - 8

end

function ServeState:render()
    self.ball:render()
    self.paddle:render()
end

