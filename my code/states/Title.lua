Title = Class{ __includes = BaseState }

function Title:update(dt)
  if love.keyboard.wasPressed('space') then
    gStateMachine:change('playing')
  end
end

function Title:render() 
  bird:render()
  love.graphics.setFont(mediumFont)
  love.graphics.printf('Press space to start!', 0, VIRTUAL_HEIGHT-50, VIRTUAL_WIDTH, 'center')
end