--[[ 
        Esta clase se encarga de permitir la impresion de mensajes de debug. 
--]]

Debug = class {}

local variables = {}        -- Tabla contenedora de las variables a mostrar en pantalla. 

--[[    Metodo para agregar variables para mostrar en pantalla de debug.
        Recibe variable a agregar.
        No tiene retorno.
--]]
function Debug.addVariable(variable)
    table.insert(variables, variable)
end

--[[    Metodo para mostrar los fps en la pantalla de debug.
        No recibe parametros.
        No tiene retorno.
--]]
function Debug.showFPS()
    love.graphics.printf(love.timer.getFPS() .. ' fps', -5, 5, VIRTUAL_WIDTH, 'right')
end

--[[    Metodo para actualizar datos a imprimir en la pantalla de debug.
        Recibe delta time.
        No tiene retorno.
--]]
function Debug.update(dt)
    variables = {}          -- En cada actualizacion se reinician las variables a mostrar.
end

--[[    Metodo para mostrar datos en la pantalla de debug.
        No recibe parametros.
        No tiene retorno.
--]]
function Debug.draw()
    love.graphics.setFont(FONTS.s)
    love.graphics.setColor(0.6,0.06,0.06,1)
    Debug.showFPS()

    for i = 1, #variables do
        love.graphics.printf( variables[i], -5, 15 + (i * 15), VIRTUAL_WIDTH, 'right')
    end
end