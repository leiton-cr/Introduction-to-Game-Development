LevelMaker = class {}

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(2, 5)
    local numCols = math.random(7, 13)

    local highestTier = math.min(3, math.floor(level / 5))
    local highestColor = math.min(4, level % 5 + 3)

    for i = 1, numRows do

        local alternate = math.random(1, 2) == 1
        local skip = math.random(1, 2) == 1

        local alternateColor1 = math.random(0, highestColor)
        local alternateColor2 = math.random(0, highestColor)

        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        local skipFlag = math.random(2) == 1
        local alternateFlag = math.random(2) == 1

        local solidColor = math.random(0, highestColor)
        local solidTier = math.random(0, highestTier)

        for j = 1, numCols do
            local color
            local tier

            if alternate and skipFlag then
                skipFlag = not skipFlag
                goto continue
            else
                skipFlag = not skipFlag
            end

            if alternate then
                color = alternate and alternateColor1 or alternateColor2
                tier = alternate and alternateTier1 or alternateTier2
                alternateFlag = not alternateFlag
            else
                color = solidColor
                tier = solidTier 
            end

            brick = Brick((j - 1) * 32 + ((VIRTUAL_WIDTH / 32) - numCols) * 16 -- Offset
            , i * 16, color * 4, tier)

            table.insert(bricks, brick)
        ::continue::
            
        end
    end

    return bricks
end 
