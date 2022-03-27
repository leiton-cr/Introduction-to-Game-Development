--[[ 
        En esta clase se gestiona la importacion de dependencias de las librerias y clases. 
--]]

-- [[ Librerias externas ]]
class = require 'src/libs/class'    -- Usado para la creacion de clases en POO
push = require 'src/libs/push'      -- Usado para redimension y look 'retro'

-- [[ Clases utilitarias ]]
require 'src/utils/constants'       -- Contenedor de constantes
require 'src/utils/globals'         -- Contenedor de globales
require 'src/utils/debug'           -- Clase para realizar debugging
require 'src/utils/keyboard'        -- Clase para controlar manejo de teclas presionadas

-- [[ Objetos ]]
require 'src/classes/StateMachine'  -- Maquina de estados globales

-- [[ Estados ]]
require 'src/states/BaseState'      -- Estado padre