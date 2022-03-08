Bird = class{}

local GRAVITY = 20

function Bird:init()

    self.sprite = love.graphics.newImage('assets/images/bird.png')
    self.score = 0

    self.width = self.sprite:getWidth();
    self.height = self.sprite:getHeight();

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0

end

function Bird:draw()
    love.graphics.draw(self.sprite,self.x, self.y)
end

function Bird:collides(pipe)
    if(self.x +2) + (self.width -4) >= pipe.x and 
    self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and
        self.y + 2 <= pipe.x + pipe.y then
            return true            
        end
    end
    return false
end

function Bird:update(dt)
    
    if love.keyboard.wasPressed('space') then
        self.dy = -5
        sounds.fly:play()
    end

    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy

end