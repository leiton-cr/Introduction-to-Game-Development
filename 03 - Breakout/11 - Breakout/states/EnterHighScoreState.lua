EnterHighScoreState = class { __includes = BaseState }

local chars = {
    [1] = 65,
    [2] = 65,
    [3] = 65,
}

local highlighted = 0

function EnterHighScoreState:enter(params)
    self.score = params.score
end

function EnterHighScoreState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])

        -- Calcular index del score
        
        local higherIndex = 0
        for i = 10, 1, -1 do
            if self.score > gHighScores[i].score then
                higherIndex = i
            end
        end

        for i = 10, higherIndex+1, -1 do
            gHighScores[i].name = gHighScores[i-1].name
            gHighScores[i].score = gHighScores[i-1].score
        end

        gHighScores[higherIndex].name = name
        gHighScores[higherIndex].score = self.score
        
        -- Guardar el score
        love.filesystem.write('breakout.lst', scoresToString())

        -- Cambiar de contexto
        gStateMachine:change('high_scores', { highIndex = higherIndex })
    end
    
    if love.keyboard.wasPressed('left') then
        highlighted = math.abs((highlighted - 1) % 3)
    end

    if love.keyboard.wasPressed('right') then
        highlighted = (highlighted + 1) % 3
    end

    if love.keyboard.wasPressed('up') then
        chars[highlighted + 1] = (chars[highlighted + 1] - 64) % 26 + 65 
    end

    if love.keyboard.wasPressed('down') then
        chars[highlighted + 1] = (chars[highlighted + 1] - 66) % 26 + 65 
    end

end

function EnterHighScoreState:render(dt)

    love.graphics.setFont(FONTS.m)
    love.graphics.printf( 'NEW HIGH SCORE: ' .. self.score , 0 , VIRTUAL_HEIGTH / 2 - 48, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(FONTS.l)

    if(highlighted == 0) then
        love.graphics.setColor(0.4,1,1,1)
        else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.printf( string.char(chars[1]) , 0  - 22 , VIRTUAL_HEIGTH / 2 - 16, VIRTUAL_WIDTH, 'center')
    
    if(highlighted == 1) then
        love.graphics.setColor(0.4,1,1,1)
        else
        love.graphics.setColor(1,1,1,1)
        end
    love.graphics.printf( string.char(chars[2]) , 0 , VIRTUAL_HEIGTH / 2  - 16, VIRTUAL_WIDTH, 'center')
    
    if(highlighted == 2) then
        love.graphics.setColor(0.4,1,1,1)
        else
        love.graphics.setColor(1,1,1,1)
    end
    love.graphics.printf( string.char(chars[3]) , 0  + 22 , VIRTUAL_HEIGTH / 2  - 16, VIRTUAL_WIDTH, 'center')


    love.graphics.setFont(FONTS.s)
    love.graphics.printf( '(Press enter to confirm)' ,0 , VIRTUAL_HEIGTH / 2 + 64, VIRTUAL_WIDTH, 'center')

    


end