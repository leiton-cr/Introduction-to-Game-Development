--[[ 
        Clase base para todos los estados, de esta heredan los demas estados de la aplicacion. 
--]] 

BaseState = class {}

function BaseState:init()               -- Constructor de estados
end 

function BaseState:enter(params)        -- Metodo de inicializacion de variables en estados
end 

function BaseState:exit()               -- Metodo destructor de estados
end 

function BaseState:update(dt)           -- Metodo de actualizacion de estados
end

function BaseState:draw()               -- Metodo de dibujado de estados
end 
