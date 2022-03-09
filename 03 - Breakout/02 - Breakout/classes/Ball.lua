Ball = class {}

function Ball:init()
    self.level = 0

    self.x = 0;
    self.y = 0;

    self.dx = 0;
    self.dy = 0;

    self.size = 8;

    self:setSkin()
end

function Ball:render()
    love.graphics.draw(TEXTURES.breakout,self.ballQuad,self.x,self.y)
end

function Ball:levelUp()
    self.level = self.level + 1 % 6
    self:setSkin()
end

function Ball:levelDown()
    self.level = math.min(-1, self.level -1)
    self:setSkin()
end

function Ball:getSkinRow()
    return 48 + math.floor(self.level / 4) * 8
end

function Ball:getSkinCol()
    return 96 + self.level * 8 % 32
end

function Ball:setSkin() 
    self.ballQuad = love.graphics.newQuad(
        self:getSkinRow(),      -- Inicio en X
        self:getSkinCol(),      -- Inicio en Y
        self.size,              -- Ancho
        self.size,                             
        TEXTURES.breakout
    )
end