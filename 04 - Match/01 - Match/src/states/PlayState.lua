--[[ 
        Clase base para todos los estados, de esta heredan los demas estados de la aplicacion. 
--]] PlayState = class {
    __includes = BaseState
}

function PlayState:init() -- Constructor de estados
    self.board = Board()
    self.highlighted = self.board.tiles[1][1]

    self.animating = false
    self.opacity = 1

    self.selected = nil
    self.swapped = nil

    love.mouse.setX(self.board.tiles[1][1].x + 64)
    love.mouse.setY(self.board.tiles[1][1].y + 64)

    self:fadeIn()
end

function PlayState:enter(params) -- Metodo de inicializacion de variables en estados
end

function PlayState:exit() -- Metodo destructor de estados
end

function PlayState:update(dt) -- Metodo de actualizacion de estados
    Timer.update(dt)
    if self.animating then
        return
    end

    self:handleHighlighted()

end

function PlayState:draw() -- Metodo de dibujado de estados
    love.graphics.setColor(1, 1, 1, 0.75)

    love.graphics.draw(TEXTURES.bg, 0, -- X offset
    0, -- Y offset
    0, -- Rotation
    VIRTUAL_WIDTH / (TEXTURES.bg:getWidth() - 1), -- X Scale
    VIRTUAL_HEIGTH / (TEXTURES.bg:getHeight() - 1) -- Y Scale
    )

    love.graphics.setColor(0.61, 0.06, 0.06, 0.9)
    love.graphics.rectangle('fill', self.highlighted.x - 2, self.highlighted.y - 2, 36, 36, 4)
    love.graphics.setColor(1, 1, 1, 0.95)

    self.board:draw()

    if self.selected then
        love.graphics.setColor(0.61, 0.06, 0.06, 0.9)
        love.graphics.rectangle('fill', self.selected.x - 2, self.selected.y - 2, 36, 36, 4)
        love.graphics.setColor(1, 1, 1, 0.95)
    end

    if self.swapped then
        love.graphics.setColor(0.61, 0.06, 0.06, 0.9)
        love.graphics.rectangle('fill', self.swapped.x - 2, self.swapped.y - 2, 36, 36, 4)
        love.graphics.setColor(1, 1, 1, 0.95)
    end

    love.graphics.setColor(0, 0, 0, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGTH)
end

function PlayState:handleHighlighted()

    if Keyboard.wasPressed('down') then
        self.highlighted = self.board.tiles[(self.highlighted.row + 1) % 8][self.highlighted.col]

        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if Keyboard.wasPressed('up') then
        self.highlighted = self.board.tiles[(self.highlighted.row - 1) % 8][self.highlighted.col]

        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if Keyboard.wasPressed('left') then
        self.highlighted = self.board.tiles[self.highlighted.row][(self.highlighted.col - 1) % 8]

        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if Keyboard.wasPressed('right') then
        self.highlighted = self.board.tiles[self.highlighted.row][(self.highlighted.col + 1) % 8]

        SOUNDS.swap:stop()
        SOUNDS.swap:play()
    end

    if Keyboard.wasPressed('enter') or Keyboard.wasPressed('return') or Mouse.wasPressed(1) then

        if not self.selected then
            self.selected = self.highlighted
        end

        if self.swapped then

            self.swapped.row, self.selected.row = self.selected.row, self.swapped.row
            self.swapped.col, self.selected.col = self.selected.col, self.swapped.col

            self.animating = true
            Timer.tween(0.25, {
                [self.swapped] = self.swapped:calculateXY(),
                [self.selected] = self.selected:calculateXY()
            }):finish(function()
                self.animating = false
            end)

            self.selected = nil
        end

        self.swapped = nil
    end

    for i = 1, 8 do

        for j = 1, 8 do
            if Mouse.hover(self.board.tiles[j][i]) then
                self.highlighted = self.board.tiles[j][i]

                if self.selected and self.selected ~= self.highlighted then
                    self.swapped = self.highlighted

                    -- Si no es adyacente no permite hacer swap
                    if not (math.abs((self.swapped.row - self.selected.row)) == 1 and
                        (self.selected.col - self.swapped.col) == 0) and
                        not (math.abs((self.swapped.col - self.selected.col)) == 1 and
                            (self.selected.row - self.swapped.row) == 0) then
                        self.swapped = nil
                    end

                end

            end
        end
    end

end

function PlayState:fadeOut()
    self.animating = true
    Timer.tween(0.75, {
        [self] = {
            opacity = 1
        }
    }):finish(function()
        -- Change state
    end)
end

function PlayState:fadeIn()
    Timer.tween(0.75, {
        [self] = {
            opacity = 0
        }
    }):finish(function()
        self.animating = false
    end)
end
