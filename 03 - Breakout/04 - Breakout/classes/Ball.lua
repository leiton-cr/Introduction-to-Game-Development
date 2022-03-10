Ball = class {}

local BALL_SIZE = 8

function Ball:init()
    self.level = math.random(0,4);

    self.x = VIRTUAL_WIDTH / 2 - 4;
    self.y = VIRTUAL_HEIGTH / 2 - 4;

    self.dx = -100;
    self.dy = -100;

    self:setSkin()
end

function Ball:render()
    love.graphics.draw(
        TEXTURES.breakout,
        self.ballQuad,
        self.x,
        self.y
    )
end



function Ball:levelUp(n)
    self.level = math.min(self.level + (n or 1), 6)
    self:setSkin()
end

function Ball:levelDown(n)
    self.level = math.max(0, self.level - (n or 1))
    self:setSkin()
end

function Ball:getSkinRow()
    return 48 + math.floor(self.level / 4) * 8
end

function Ball:getSkinCol()
    return 96 + self.level * 8 % 32
end

function Ball:collides(target)
    if self.x > target.x + target.width or target.x > self.x + BALL_SIZE then
        return false
    end
    
    if self.y > target.y + target.heigth or target.y > self.y + BALL_SIZE then
        return false
    end

    return true

end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGTH / 2 - 2

    self.dx = 100
    self.dy = 100
end

function Ball:update(dt)
   
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        SOUNDS['wall_hit']:play()
    end 

    if self.x >= VIRTUAL_WIDTH-8 then
       self.x = VIRTUAL_WIDTH-8
       self.dx = -self.dx
       SOUNDS['wall_hit']:play()
    end 

  
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        SOUNDS['wall_hit']:play()
    end 

    if self.y >= VIRTUAL_HEIGTH-8 then
     
    end 

    self.x = self.x + (self.dx * dt)
    self.y = self.y + (self.dy * dt)

end


function Ball:setSkin() 
    self.ballQuad = love.graphics.newQuad(
        self:getSkinCol(),      -- Inicio en X
        self:getSkinRow(),      -- Inicio en Y
        BALL_SIZE,              -- Ancho
        BALL_SIZE,                             
        TEXTURES.breakout
    )
end