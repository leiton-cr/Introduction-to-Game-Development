--[[ 
        Clase base para todos los estados, de esta heredan los demas estados de la aplicacion. 
--]] 

BaseState = class {}

local timers = {0,0,0,0,0,0};           -- Control de tiempos
local intervals = {1,2,3,4,5,6};        -- Intervalos de aumento

function BaseState:init()               -- Constructor de estados
end 

function BaseState:enter(params)        -- Metodo de inicializacion de variables en estados
        setTimers()
        
end 

function BaseState:exit()               -- Metodo destructor de estados
end 

function BaseState:update(dt)           -- Metodo de actualizacion de estados
        Timer.update(dt)                -- Se actualizan los temporizadores
end

function BaseState:draw()               -- Metodo de dibujado de estados

        for i = 1, #timers do
                love.graphics.printf('Segundos: ' .. timers[i] .. ' cada ' .. intervals[i] ,0, 32 * i,VIRTUAL_WIDTH, 'center')        
        end

end 


--[[
        Esta funcion inicializa los temportizadores necesarios en el estado
        No recibe parametros
        No tiene retorno
]]
function setTimers()
        for i = 1, #timers do
                Timer.every(intervals[i], function ()
                        timers[i] = timers[i]+1
                end)        
        end
end