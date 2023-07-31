PipePair = Class {}

function PipePair:init(y)
  self.top = Pipe('top', y - PIPE_DIST - PIPE_HEIGHT)
  self.bottom = Pipe('bottom', y)
  self.x = VIRTUE_WIDTH
  self.passAway = false
  self.scrollOver = false
end

function PipePair:shouldRemove()
  return self.passAway
end

function PipePair:shouldAdd()
  if self.scrollOver then
    return false
  end

  if bird.x > self.top.x + PIPE_WIDTH then
    self.scrollOver = true
    return true
  end

  return false
end

function PipePair:update(dt) 
  self.top:update(dt)
  self.bottom:update(dt)
  if self.top.x < -PIPE_WIDTH then
    self.passAway = true
  end
end

function PipePair:render() 
  self.top:render()
  self.bottom:render()
end
