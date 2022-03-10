require 'utils/dependencies'

function love.load()

    --[[ Basic configuration ]]

    math.randomseed(os.time())
    love.window.setTitle('Brakeout')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGTH, WINDOW_WIDTH, WINDOW_HEIGTH, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    --[[ Keyboard handler ]]
    love.keyboard.pressed = {}

    --[[ State handler ]]
    gStateMachine = StateMachine({
        ["title"] = function()
            return TitleState()
        end,
        ["paddle_select"] = function()
            return PaddleSelectState()
        end,
        ["high_scores"] = function()
            return HighScoreState()
        end,
        ["play"] = function()
            return PlayState()
        end,
        ["serve"] = function()
            return ServeState()
        end,
        ["game_over"] = function()
            return OverState()
        end
    })

    --[[ Initial state ]]
    gStateMachine:change("paddle_select")
end

function love.keypressed(key)
    love.keyboard.pressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.pressed[key]
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

    --[[ Update actual state ]]
    gStateMachine:update(dt)

    --[[ Restart pressed keys ]]
    love.keyboard.pressed = {}

end

function love.draw()

    push:start()

    love.graphics.draw(TEXTURES.bg, 0, 0, 0, VIRTUAL_WIDTH / (TEXTURES.bg:getWidth() - 1),
        VIRTUAL_HEIGTH / (TEXTURES.bg:getHeight() - 1))

       

    --[[ Render actual state ]]
    gStateMachine:render()

    displayFPS()
    push:finish()

end

function renderHealth(health)
    for i = 1, health do
        love.graphics.draw(TEXTURES.breakout, HEALTH_QUAD.full, 11 * i, 2)
    end

    for i = 1, 3 - health do
        love.graphics.draw(TEXTURES.breakout, HEALTH_QUAD.empty, 11 * i + 11 * health, 2)
    end
end

function renderScore(score)
    love.graphics.setFont(FONTS.s)
    love.graphics.print('Score: ' .. score, 50, 3)
end
