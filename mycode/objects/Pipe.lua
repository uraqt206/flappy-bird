Pipe = Class {}

function Pipe:init(type, y)
  self.type = type
  self.x = VIRTUAL_WIDTH
  self.y = y
end

function Pipe:update(dt) 
  self.x = self.x - PIPE_SPEED * dt
end

function Pipe:render() 
  if self.type == 'bottom' then
    love.graphics.draw(PIPE, self.x, self.y)
  else
    love.graphics.draw(PIPE, self.x, self.y + PIPE_HEIGHT, 0, 1, -1)
  end
end
