Paddle = class {}

--[[
    Posicion del paddle en X,Y y su ancho segun el nivel.
    Se realiza un ajuste segun el color que elija el usuario.
]]
local PADDLE_SIZE = {
    [1] = {
        x = 0,
        y = 0,
        w = 32
    },
    [2] = {
        x = 32,
        y = 0,
        w = 64
    },
    [3] = {
        x = 96,
        y = 0,
        w = 96
    },
    [4] = {
        x = 0,
        y = 16,
        w = 128
    }
}

function Paddle:init()
    self.health = 3
    self.skin = 0

    self.width = 32 * self.health
    self.heigth = 16

    self.score = 0

    self.x = (VIRTUAL_WIDTH / 2) - (self.width / 2)
    self.y = (VIRTUAL_HEIGTH) - (self.heigth * 4)

    self.dx = 0

    self:setSkin()
end

function Paddle:render()
    love.graphics.draw(TEXTURES.breakout, self.paddleQuad, self.x, self.y)
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    end

    if love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    end

    if self.dx > 0 then
        self.x = math.min(self.x + (self.dx * dt), VIRTUAL_WIDTH - self.width)
    elseif self.dx < 0 then
        self.x = math.max(self.x + (self.dx * dt), 0)
    end

    self.dx = self.dx * PADDLE_FRICTION

end

function Paddle:previousSkin()
    self.skin = (self.skin - 1) % 4
    self:setSkin();
end

function Paddle:nextSkin()
    self.skin = (self.skin + 1) % 4
    self:setSkin();
end

function Paddle:setSkin()
    self.paddleQuad = love.graphics.newQuad(PADDLE_SIZE[self.health].x, -- Inicio en X
    (64 + (32 * self.skin)) + PADDLE_SIZE[self.health].y, -- Inicio en Y
    PADDLE_SIZE[self.health].w, -- Ancho
    self.heigth, TEXTURES.breakout)
end

function Paddle:setWidth()
    self.width = 32 * self.health
end

function Paddle:healthUp()
    self.health = math.min(4, self.health + 1)
    self:setWidth()
    self:setSkin()
end

function Paddle:healthDown()
    SOUNDS.hurt:play()
    self.health = math.max(0, self.health - 1)
    self:setWidth()
    if self.health > 0 then
        self:setSkin()
    end
end

function Paddle:healthUp()
    SOUNDS.recover:play()
    self.health = math.min(3, self.health + 1)
    self:setWidth()
    self:setSkin()
end
