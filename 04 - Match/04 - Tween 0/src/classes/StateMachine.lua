--[[ 
        Esta clase se encarga de manejar los estados de la aplicacion. 
--]]

StateMachine = class {}

--[[
    Metodo de inicializacion.
    Recibe Estados de la aplicacion.
    No tiene retorno.
--]]
function StateMachine:init(states)
    self.empty = BaseState()
    self.states = states or {}
    self.current = self.empty
end

--[[
    Metodo de cambio del estado actial.
    Recibe el nombre del estado a activar y los parametros de este estado.
    No tiene retorno.
--]]

function StateMachine:change(state, params)
    assert(self.states[state])                  -- Verifica la existencia del estado.
    self.current:exit()                         -- Ejecuta la destruccion del estado actual.
    self.current = self.states[state]()         -- Crea el nuevo estado.
    self.current:enter(params)                  -- Entra al nuevo estado.
end

--[[
    Metodo de actualizacion.
    Recibe Delta Time.
    No tiene retorno.
--]]
function StateMachine:update(dt)
    self.current:update(dt)                     --  Se ejecuta el metodo de actualizacion del estado actual.
end

--[[
    Metodo de renderizado.
    Recibe Delta Time
    No tiene retorno
--]]
function StateMachine:draw()
    self.current:draw()                         -- Dibuja en pantalla el contenido del estado actual.
end

--[[
        Metodo de creacion de maquina de estados.   
        No recibe parametros.
        No tiene retorno.
--]]
function StateMachine.startupStateMachine() 
    gStateMachine = StateMachine(
        { 
            ['base'] = function() return BaseState() end    -- Ejemplo de estado base.
        }
    )

    gStateMachine:change('base',{})
end