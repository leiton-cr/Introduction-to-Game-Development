--[[ 
        En este codigo se gestiona la importacion de dependencias de las librerias y clases. 
--]]

-- [[ Librerias externas ]]
class = require 'src/libs/class'    -- Usado para la creacion de clases en POO
push = require 'src/libs/push'      -- Usado para redimension y look 'retro'
Timer = require 'src/libs/timer'      -- Usado para redimension y look 'retro'

-- [[ Clases utilitarias ]]
require 'src/utils/constants'       -- Contenedor de constantes
require 'src/utils/globals'         -- Contenedor de globales
require 'src/utils/debug'           -- Clase para realizar debugging
require 'src/utils/keyboard'        -- Clase para controlar manejo de teclas presionadas
require 'src/utils/mouse'        -- Clase para controlar manejo de teclas presionadas

-- [[ Objetos ]]
require 'src/classes/StateMachine'  -- Maquina de estados globales
require 'src/classes/Tile'
require 'src/classes/Scoring'
require 'src/classes/Board'

-- [[ Estados ]]
require 'src/states/BaseState'      -- Estado padre
require 'src/states/TitleState'      -- Estado de menu inicial
require 'src/states/PlayState'      -- Estado de menu inicial