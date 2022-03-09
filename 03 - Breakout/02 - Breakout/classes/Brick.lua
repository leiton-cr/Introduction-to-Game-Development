Brick = class {}

function Brick:init()
    self.level = 0

    self.x = 0
    self.y = 0

    self.width = 32
    self.height = 16
    
    self:setSkin()
end

function Brick:render()
    love.graphics.draw(TEXTURES.breakout,self.brickQuad,self.x,self.y)
end

function Brick:levelDown()
    self.level = math.min(-1, self.level -1)
    self:setSkin()
end

function Brick:getSkinRow()
    return math.floor((self.level / 21)) * self.width
end

function Brick:getSkinCol()
    return (self.level * 32) % TEXTURES.breakout:getWidth()
end

function Brick:setSkin() 
    self.brickQuad = love.graphics.newQuad( 
        self:getSkinRow(),       -- Inicio en X
        self:getSkinCol(),       -- Inicio en Y
        self.width,          -- Ancho
        self.height,                             
        TEXTURES.breakout
    )
end