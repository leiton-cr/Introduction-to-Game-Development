Brick = class {}

COLORS = {
    [1] = {
        ['r'] = 99 / 255,
        ['g'] = 155 / 255,
        ['b'] = 255 / 255,
    },
    [2] = {
        ['r'] = 106 / 255,
        ['g'] = 190 / 255,
        ['b'] = 47 / 255,
    },
    [3] = {
        ['r'] = 217 / 255,
        ['g'] = 87 / 255,
        ['b'] = 99 / 255,
    },
    [4] = {
        ['r'] = 215 / 255,
        ['g'] = 123 / 255,
        ['b'] = 186 / 255,
    },
    [5] = {
        ['r'] = 251 / 255,
        ['g'] = 242 / 255,
        ['b'] = 54 / 255,
    }
}

function Brick:init(x, y, color, tier)
    self.skinTone = 0

    self.color = color or 0
    self.tier = tier or 0

    self.x = x
    self.y = y

    self.width = 32
    self.heigth = 16

    self.particles = love.graphics.newParticleSystem(TEXTURES.particle, 64)
    
    -- Tiempo de vida entre 0.5 y 1 segundo
    self.particles:setParticleLifetime(0.5, 1)

    -- Aceleracion entre X1 Y1 y X2 Y2
    self.particles:setLinearAcceleration(-15,0,15,80)

    -- Propagacion de las particulas 
    self.particles:setEmissionArea('normal', 10, 10)

    self:setSkin()
end

function Brick:render()
    if self.color >= 0 then
        love.graphics.draw(TEXTURES.breakout, self.brickQuad, self.x, self.y)
    end
end

function Brick:update(dt)
    self.particles:update(dt)
end

function Brick:hit()
    SOUNDS.brick_hit_2:stop()
    SOUNDS.brick_hit_2:play()
    
  

    self.particles:setColors(
        COLORS[self.color / 4 + 1].r,
        COLORS[self.color / 4 + 1].g,
        COLORS[self.color / 4 + 1].b,
        (55 * (self.tier+1 )) / 255,
        COLORS[self.color / 4 + 1].r,
        COLORS[self.color / 4 + 1].g,
        COLORS[self.color / 4 + 1].b,
        0
    )

    self:levelDown()

    self.particles:emit(64)

end

function Brick:levelDown()

    if self.tier > 0 then

        if self.color == 0 then
            self.tier = self.tier - 1
            self.color = 4
        else
            self.color = self.color - 4
            self.tier = 3
        end

    else

        if self.color == 0 then
            self.color = -1
        else
            self.color = self.color - 4
        end

    end


    self:setSkin()
end

function Brick:getSkinRow()
    return math.floor((self.skinTone / 6)) * self.heigth
end

function Brick:getSkinCol()
    return (self.skinTone * 32) % TEXTURES.breakout:getWidth()
end

function Brick:setSkin()
    self.skinTone = self.color + self.tier;
    self.brickQuad = love.graphics.newQuad(self:getSkinCol(), -- Inicio en X
    self:getSkinRow(), -- Inicio en Y
    self.width, -- Ancho
    self.heigth, TEXTURES.breakout)
end

function Brick:renderParticles()
    love.graphics.draw(self.particles, self.x + 16, self.y + 8)
end