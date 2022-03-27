--[[ 
        Esta clase se encarga de llevar el control del mouse
--]]

Mouse = class{}

local pressed = {}               -- Tabla contenedora de botones de mouse presionados.

--[[    Metodo para actualizar datos del mouse.
        No recibe parametros.
        No tiene retorno.
--]]
function Mouse.update(dt)
        pressed = {}
end

--[[    Metodo para obtencion de mouse en x.
        No recibe parametros.
        Retorna posicion de mouse en eje X
--]]
function Mouse.getX()
        return  (love.mouse.getX() / love.graphics.getWidth()) * VIRTUAL_WIDTH
end

--[[    Metodo para obtencion de mouse en y.
        No recibe parametros.
        Retorna posicion de mouse en eje y
--]]
function Mouse.getY()
        return (love.mouse.getY() / love.graphics.getHeight()) * VIRTUAL_HEIGTH
end

--[[    Metodo para calculo de colision sobre caja.
        Recibe un objeto con posicion (x,y) y dimensiones (w,h).
        Retorna si un boleano indicando si existe o no la colision
--]]
function Mouse.hover(object)
    return Mouse.getX() > object.x 
       and Mouse.getY() > object.y 
       and Mouse.getX() < object.x + object.w 
       and Mouse.getY() < object.y + object.h
end

--[[    Metodo para validar si una tecla fue presionada.
        Recibe el nombre de la tecla.
        Retorna un boolean indicando si la tecla fue presionada o no.
--]]
function Mouse.wasPressed(key)
        return pressed[key]
end

--[[    Sobreescritura del metodo love para boton de mouse presionado.
        Recibe el nombre del boton y lo asigna a la tabla.
        No tiene retorno.
--]]
function love.mousepressed(x , y , button)
        pressed[button] = button
end