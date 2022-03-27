--[[ 
        Clase base para todos los estados, de esta heredan los demas estados de la aplicacion. 
--]] 

BaseState = class {}

local seconds = 0;
local timing = 0;

function BaseState:init()               -- Constructor de estados
end 

function BaseState:enter(params)        -- Metodo de inicializacion de variables en estados
end 

function BaseState:exit()               -- Metodo destructor de estados
end 

function BaseState:update(dt)           -- Metodo de actualizacion de estados
        timing = timing + dt

        if timing >= 1 then
                timing = timing % 1
                seconds = seconds + 1
        end

end

function BaseState:draw()               -- Metodo de dibujado de estados
        love.graphics.printf('Segundos: ' .. seconds ,0, VIRTUAL_HEIGTH /4,VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Segundos: ' .. seconds/2 ,0, VIRTUAL_HEIGTH /3,VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Segundos: ' .. seconds/4 ,0, VIRTUAL_HEIGTH /2,VIRTUAL_WIDTH, 'center')
end 
