Tile = class {}

ind = 1

function Tile:init(i,j)
    self.col = i
    self.row = j
  
    self.color = math.random(12);
    self.tier = math.random(6);

    self.x = (self.col * 32);
    self.y = (self.row * 32) - 16;

    self.w = 32;
    self.h = 32;
    
    self.sprite = TILE_COLORS[ ((self.color - 1) * 6) + self.tier];
    --self.sprite = TILE_COLORS[ ind ];
    --ind = ind +1
 
end

function Tile:draw()
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.draw(TEXTURES.tiles, self.sprite, self.x, self.y)
end

function Tile:calculateXY()
    return {x = self.col * 32, y = self.row * 32 - 16}
end


