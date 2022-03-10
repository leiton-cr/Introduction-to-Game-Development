Brick = class {}

function Brick:init(x, y, color, tier)
    self.skinTone = 0

    self.color = color
    self.tier = tier

    self.x = x
    self.y = y

    self.width = 32;
    self.heigth = 16;

    self:setSkin()
end

function Brick:render()
    if self.color >= 0 then
        love.graphics.draw(TEXTURES.breakout, self.brickQuad, self.x, self.y)
    end
end

function Brick:update(dt)
end

function Brick:hit()
    SOUNDS.brick_hit_1:play()
    self:levelDown()
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
