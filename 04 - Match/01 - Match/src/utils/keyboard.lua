--[[ 
        Esta clase se encarga de llevar el control de las teclas presionadas. 
--]]

Keyboard = class{}

local pressed = {}               -- Tabla contenedora de las teclas presionadas.

--[[    Metodo para actualizar datos de teclado.
        No recibe parametros..
        No tiene retorno.
--]]
function Keyboard.update(dt)
    pressed = {}                 -- En cada actualizacion se reinician las teclas presionadas.
end

--[[    Sobreescritura del metodo love para teclas presionadas.
        Recibe el nombre de la tecla y lo asigna a la tabla.
        No tiene retorno.
--]]
function love.keypressed(key)
    pressed[key] = true;
end

--[[    Metodo para validar si una tecla fue presionada.
        Recibe el nombre de la tecla.
        Retorna un boolean indicando si la tecla fue presionada o no.
--]]
function Keyboard.wasPressed(key)
    return pressed[key]
end