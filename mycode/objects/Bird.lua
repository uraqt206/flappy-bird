Bird = Class{}
GRAVITY = 20

function Bird:init() 
  self.image = love.graphics.newImage('pictures/bird.png')
  self.height = self.image:getHeight()
  self.width =  self.image:getWidth()
  self.x = VIRTUAL_WIDTH/2 - self.width/2
  self.y = VIRTUAL_HEIGHT/2 - self.height/2
  self.dy = 0
end

function Bird:update(dt) 
  if love.keyboard.wasPressed('space') then
    self.dy = -5
  end
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy
end

function Bird:collides(pipe)
  if self.y + self.height < pipe.y then
    return false
  elseif self.y > pipe.y + PIPE_HEIGHT then
    return false
  elseif self.x + self.width < pipe.x then
    return false
  elseif self.x > pipe.x + PIPE_WIDTH then
    return false 
  else 
    return true 
  end
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end