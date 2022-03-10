
function displayFPS()
    -- [[ Set the debug font and color ]]
    love.graphics.setFont(FONTS.s)
    love.graphics.setColor(0, 1, 0, 1)

    -- [[ Draw debug messages ]]
    love.graphics.printf( love.timer.getFPS() ..' fps',-10 ,10, VIRTUAL_WIDTH,'right')

    -- [[ Reset to white color ]]
    love.graphics.setColor(1, 1, 1, 1)
end