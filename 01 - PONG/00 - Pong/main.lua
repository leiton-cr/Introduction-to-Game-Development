WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

function love.update(dt)
end

function love.draw()
    love.graphics.printf(
        'Hello PONG!', 
        0,                      -- Inicio en X 
        WINDOW_HEIGHT / 2 - 6,  -- Inicio en y
        WINDOW_WIDTH,           -- Pixeles para centrar
        'center'                -- Posicion
    )
end
