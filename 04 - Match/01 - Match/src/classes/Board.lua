Board = class{}

function Board:init()
    self.tiles = self:CreateTiles()
end

function Board:CreateTiles()
   
    local tiles = {}

    for x = 1, 8 do
        local row = {}
        for y = 1, 8 do
            table.insert(row, Tile(x,y))
        end
        table.insert(tiles, row)
    end
    
    return tiles
end

function Board:draw()
    for key, row in pairs(self.tiles) do
      for k, tile in pairs(row) do
        tile:draw()
      end
    end
end