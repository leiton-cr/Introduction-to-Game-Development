HighScoreState = class {__includes = BaseState}

function HighScoreState:init()
    self.highIndex = 0; 
end

function HighScoreState:enter(params)
    if(params) then
        self.highIndex = params.highIndex
    end
    
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end    
end

function HighScoreState:render()
    love.graphics.setFont(FONTS.l)
    love.graphics.printf("HIGH SCORES."  , 0, 24,VIRTUAL_WIDTH,'center');

    love.graphics.setFont(FONTS.m)
    for  i = 1, 10 do
        if(i == self.highIndex) then
            love.graphics.setColor(0.4,1,1,1)
        end

        love.graphics.printf(i , 64 , 64 + (16 * i),VIRTUAL_WIDTH,'left');
        love.graphics.printf(gHighScores[i].name, 0, 64 + (16 * i),VIRTUAL_WIDTH,'center');
        love.graphics.printf(gHighScores[i].score, -64 , 64 + (16 * i),VIRTUAL_WIDTH,'right');
        
        if(i == self.highIndex) then
            love.graphics.setColor(1,1,1,1)
        end
    end

    love.graphics.setFont(FONTS.s)
    love.graphics.printf("(Press escape to go to title screen)"  , 0, VIRTUAL_HEIGTH - 24,VIRTUAL_WIDTH,'center');
end