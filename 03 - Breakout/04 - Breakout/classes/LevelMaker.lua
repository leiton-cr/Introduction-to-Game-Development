LevelMaker = class{}

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(1,5)
    local numCols = math.random(7,13)

    for i = 1, numRows do
        for j=  1, numCols do
            brick = Brick(

                (j-1) *
                32 + 
                8 +  
                (13-numCols) * 16,

                i * 16
            )

            table.insert(bricks, brick)
        end
    end

    return bricks
end