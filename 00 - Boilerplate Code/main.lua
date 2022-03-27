require 'src/utils/dependencies' -- Importacion de dependencias

--[[    
        Metodo de inicializacion llamado una vez
        No recibe parametros.
        No tiene retorno.
--]]
function love.load()

    --[[ Configuracion basica. ]]
    math.randomseed(os.time())
    love.window.setTitle('Boilerplate')

    --[[ Configuracion de graficos inicial. ]]
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGTH, WINDOW_WIDTH, WINDOW_HEIGTH, {
        vsync = true,
        resizable = true,
        fullscreen = false
    })

    --[[ inicializaciones varias. ]]
    StateMachine.startupStateMachine() 

end

--[[    
        Metodo de resize llamado cada vez que se cambia el tamaño de la pantalla.
        Recibe parametros de ancho y alto.
        No tiene retorno.
--]]
function love.resize(w, h)
    push:resize(w, h)             -- Se propaga el resize a la libreria push.         
end

--[[    
        Metodo de actualizacion llamado en cada iteracion.
        Recibe delta time.
        No tiene retorno.
--]]
function love.update(dt)
    Debug.update(dt)            -- Actualizacion de pantalla de debug.

    Keyboard.update(dt)         -- Actualizacion de keyboard.
end

--[[ 
        Metodo de dibujado llamado en cada iteracion.   
        No recibe parametros.
        No tiene retorno.
--]]
function love.draw()
    push:start()                -- Inicio del escalado virtual.  
        Debug.draw()
    push:finish()               -- Fin del escalado virtual.
end