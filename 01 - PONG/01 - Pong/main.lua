--[[
    Libreria que permite dibujar el juego a una 
    resolucion virtual sin importar el tamaño de 
    la ventana. 
]] --
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Inicializar el juego, corre solo una vez.
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(
        VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
        WINDOW_WIDTH, WINDOW_HEIGHT, 
        {
        fullscreen = false,
        resizable = false,
        vsync = true
        }
    )
end

-- Actualizar parametros.
function love.update(dt)
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end

-- Renderizado.
function love.draw()

    push:apply('start') -- Starts virtual resolution

    love.graphics.printf('Hello PONG!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    push:apply('end') -- Ends virtual resolution

end
