Debug = class{}

function Debug:init()
    self.debugFont = love.graphics.newFont('assets/fonts/flappy.ttf', 16)
end

function Debug:displayFPS()
    love.graphics.setFont(self.debugFont)
    love.graphics.printf( 
        tostring(love.timer.getFPS()) ..' fps',
        0, 10, WINDOW_WIDTH - 20, 'right' )
end