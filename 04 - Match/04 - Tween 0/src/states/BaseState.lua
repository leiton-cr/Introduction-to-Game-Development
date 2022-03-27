--[[ 
        Clase base para todos los estados, de esta heredan los demas estados de la aplicacion. 
--]] 

BaseState = class {}

local timers = {0};           -- Control de tiempos
local intervals = {1};        -- Intervalos de aumento

function BaseState:init()               -- Constructor de estados

        rate = math.random() * 10       -- Duracion total para atravesar la pantalla
        
        maxX = (VIRTUAL_WIDTH - 32)

        bird = {
                x = 0,
                y = VIRTUAL_WIDTH / 2,
                opacity = 0.5
        }

        Timer.tween(rate, {
                [bird] = {x = VIRTUAL_WIDTH - 32, opacity = 1}
        })

end 

function BaseState:enter(params)        -- Metodo de inicializacion de variables en estados                  -- Se inicializan los temporizadores
        
        sprite = love.graphics.newImage('assets/graphics/flappy.png')
       
end 

function BaseState:exit()               -- Metodo destructor de estados
end 

function BaseState:update(dt)           -- Metodo de actualizacion de estados
       
        timers[1] = timers[1] + dt

        Timer.update(dt)
end

function BaseState:draw()               -- Metodo de dibujado de estados

        for i = 1, #timers do
                love.graphics.printf('Segundos: ' .. timers[i] .. ' cada ' .. intervals[i] ,0, 32 * i,VIRTUAL_WIDTH, 'center')        
        end


        love.graphics.setColor(1,1,1,bird.opacity)
        love.graphics.draw(sprite,bird.x,bird.y)
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