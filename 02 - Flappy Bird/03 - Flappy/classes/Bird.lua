Bird = class{}

function Bird:init()

    self.sprite = love.graphics.newImage('assets/images/bird.png')
    self.score = 0

    self.width = self.sprite:getWidth();
    self.height = self.sprite:getHeight();

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 100

end

function Bird:draw()
    love.graphics.draw(self.sprite,self.x, self.y)
end