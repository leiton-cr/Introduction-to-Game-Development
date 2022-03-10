Brick = class {}

function Brick:init(x,y)
    self.skinTone = 0

    self.color = math.random(0,4) * 4
    self.tier = 0

    self.x = x
    self.y = y

    self.width = 32;
    self.heigth = 16;

    self:setSkin()
end

function Brick:render()
    if self.tier >= 0 then
        love.graphics.draw(
            TEXTURES.breakout,
            self.brickQuad,
            self.x,
            self.y
        )
    end
end

function Brick:update(dt)
end

function Brick:hit()
    SOUNDS.brick_hit_1:play()
    self:levelDown()    
end

function Brick:levelDown()
    self.tier = self.tier - 1
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
    self.brickQuad = love.graphics.newQuad( 
        self:getSkinCol(),      -- Inicio en X
        self:getSkinRow(),      -- Inicio en Y
        self.width,            -- Ancho
        self.heigth,                             
        TEXTURES.breakout
    )
end