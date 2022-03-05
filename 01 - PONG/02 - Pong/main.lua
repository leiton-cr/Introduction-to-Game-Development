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
    font = love.graphics.newFont('font.ttf', 8);
    love.graphics.setFont(font);

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

    love.graphics.clear(40,45,52,0.3)

    love.graphics.printf('Hello PONG!', 0, 10 - 6, VIRTUAL_WIDTH, 'center')

    love.graphics.rectangle('fill', 10,30,5,20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 ,4,4)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30,5,20)
    
    push:apply('end') -- Ends virtual resolution
end
