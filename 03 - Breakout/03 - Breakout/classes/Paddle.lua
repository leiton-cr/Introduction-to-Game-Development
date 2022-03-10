Paddle = class {}

--[[
    Posicion del paddle en X,Y y su ancho segun el nivel.
    Se realiza un ajuste segun el color que elija el usuario.
]]
local PADDLE_SIZE = {
    [1] = {x = 0 , y = 0, w = 32},
    [2] = {x = 32, y = 0, w = 64},
    [3] = {x = 96, y = 0, w = 96},
    [4] = {x = 0 , y = 16, w = 128}
}

function Paddle:init()
   self.level = 3
   self.skin = 0

   self.width = 32 * self.level
   self.heigth = 16

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
    self.paddleQuad = love.graphics.newQuad( 
        PADDLE_SIZE[self.level].x,                              -- Inicio en X
        (64 + (32 * self.skin)) + PADDLE_SIZE[self.level].y,    -- Inicio en Y
        PADDLE_SIZE[self.level].w,                              -- Ancho
        self.heigth,                             
        TEXTURES.breakout)
end

function Paddle:setWidth()
    self.width = 32 * self.level
end

function Paddle:levelUp()
    self.level = math.min(4,self.level+1)
    self:setWidth()
end

function Paddle:levelDown()
    self.level = math.max(1,self.level-1)
    self:setWidth()
end