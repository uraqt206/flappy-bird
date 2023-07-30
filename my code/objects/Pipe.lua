Pipe = Class{}
local IMAGE = love.graphics.newImage('pictures/pipe.png')
PIPE_WIDTH = IMAGE:getWidth()
PIPE_HEIGHT = IMAGE:getHeight()
local SCROLL_SPEED = 60

function Pipe:init()
    self.x = VIRTUAL_WIDTH
    self.y = math.random(72, 260)
    self.dist = math.random(50, 70)
end

function Pipe:update(dt) 
    self.x = self.x - SCROLL_SPEED * dt
end

function Pipe:render() 
    love.graphics.draw(IMAGE, self.x, self.y)
end