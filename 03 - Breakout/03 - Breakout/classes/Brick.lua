Brick = class {}

local BRICK_WIDTH = 32
local BRICK_HEIGTH = 16

function Brick:init()
    self.level = 0

    self.x = 0
    self.y = 0

    self:setSkin()
end

function Brick:render()
    love.graphics.draw(TEXTURES.breakout,self.brickQuad,self.x,self.y)
end

function Brick:levelDown(n)
    self.level = math.min(-1, self.level - (n or 1))
    self:setSkin()
end

function Brick:getSkinRow()
    return math.floor((self.level / 21)) * BRICK_WIDTH
end

function Brick:getSkinCol()
    return (self.level * 32) % TEXTURES.breakout:getWidth()
end

function Brick:setSkin() 
    self.brickQuad = love.graphics.newQuad( 
        self:getSkinRow(),      -- Inicio en X
        self:getSkinCol(),      -- Inicio en Y
        BRICK_WIDTH,            -- Ancho
        BRICK_HEIGTH,                             
        TEXTURES.breakout
    )
end