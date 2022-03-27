--[[ 
		Clase que se encarga del menu inicial de la aplicacion. 
--]] 

TitleState = class { __includes = BaseState }

local highlighted = 0 -- Variable que controla la opcion resaltada por el usuario

function TitleState:init()

    -- [[ Variables que controlan el color de cada letra activa ]] -- 
    self.colors = {
        [1] = {0.61, 0.06, 0.06, 0.9},
        [2] = {0.95, 0.95, 0.95, 0.9},
        [3] = {0.61, 0.06, 0.06, 0.9},
        [4] = {0.95, 0.95, 0.95, 0.9},
        [5] = {0.61, 0.06, 0.06, 0.9},
        [6] = {0.95, 0.95, 0.95, 0.9},
        [7] = {0.61, 0.06, 0.06, 0.9}
    }

    -- [[ Variables que controlan la letra, posicion y color que se imprimira ]] --
    self.letters = {
        [1] = {'M', -50, 1},
        [2] = {'A', -30, 2},
        [3] = {'T', -14, 3},
        [4] = {'C', 0, 4},
        [5] = {'H', 16, 5},
        [6] = {'-', 35, 6},
        [7] = {'3', 52, 7}
    }

    self.animating = false      -- Flag para controlar si hay una animacion en curso.
    self.opacity = 0            -- Variable para controlar la opacidad de las animaciones.
    
    self:initializeTitleTimer()
end

function TitleState:update(dt)
    Timer.update(dt)

    if self.animating then      -- Si hay una animacion activa no continua
        return
    end

    if  Keyboard.wasPressed('down') or ( Mouse.hover( {x = 200, y = 175, w = 110, h = 16} ) and highlighted ~= 0 ) then
        highlighted = (highlighted + 1) % 2 -- Hacia arriba % 2 para no sobrepasar el limite.
        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if  Keyboard.wasPressed('up') or ( Mouse.hover( {x = 235, y = 207, w = 55, h = 16} ) and highlighted ~= 1 ) then
        highlighted = math.abs((highlighted - 1) % 2) -- Hacia abajo % 2 para no sobrepasar el limite abs para evitar negativos.
        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if Keyboard.wasPressed('enter') or Keyboard.wasPressed('return') 
    or (Mouse.wasPressed(1) and ( Mouse.hover( {x = 200, y = 175, w = 110, h = 16} ) or Mouse.hover( {x = 235, y = 207, w = 55, h = 16} )  )) then
        if highlighted == 1 then
            return love.event.quit()
        end
        self.titleTimer:remove()
        self:fadeOut()
    end

end

function TitleState:draw()
    love.graphics.setFont(FONTS.l)
    love.graphics.setColor(1, 1, 1, 0.75)

    love.graphics.draw(
        TEXTURES.bg,
        0,  -- X offset
        0,  -- Y offset
        0,  -- Rotation
        VIRTUAL_WIDTH / (TEXTURES.bg:getWidth()-1),     -- X Scale
        VIRTUAL_HEIGTH / (TEXTURES.bg:getHeight()-1)    -- Y Scale
    )

    for i = 1, #self.letters do
        love.graphics.setColor(0.15, 0.15, 0.15, 0.9)
        love.graphics.printf(self.letters[i][1], (self.letters[i][2]), (VIRTUAL_HEIGTH / 3)-2, VIRTUAL_WIDTH, 'center')
        love.graphics.printf(self.letters[i][1], (self.letters[i][2])-2, (VIRTUAL_HEIGTH / 3), VIRTUAL_WIDTH, 'center')

        love.graphics.setColor(self.colors[self.letters[i][3]])
        love.graphics.printf(self.letters[i][1], self.letters[i][2], VIRTUAL_HEIGTH / 3, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.setFont(FONTS.m)

    if (highlighted == 0) then
        love.graphics.setColor(0.61, 0.06, 0.06, 0.9)
    end

    love.graphics.printf("Nuevo juego", 0, VIRTUAL_HEIGTH / 2 + 32, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 0.9)

    if (highlighted == 1) then
        love.graphics.setColor(0.61, 0.06, 0.06, 0.9)
    end

    love.graphics.printf("Salir", 0, (VIRTUAL_HEIGTH / 2) + 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0, 0, 0, self.opacity)

    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGTH)

end

function TitleState:initializeTitleTimer()
    self.titleTimer = Timer.every(0.15, function()
        for i = 1, #self.letters do
            self.letters[i][3] = ((self.letters[i][3] + 1) % #self.letters) + 1
        end
    end)
end

function TitleState:fadeOut()
   
    self.animating = true
    
    Timer.tween(0.75, {
        [self] = { opacity = 1 }
    }):finish(
        function ()
            
            gStateMachine:change('playState')
        end
    )
end