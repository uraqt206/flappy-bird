Playing = Class { __includes = BaseState }

function Playing:init()
  PipePairs = {}
  timeSpawner = 0
  lastY = 200
  dead = false
  score = 0
end

function Playing:update(dt)
  -- if not dead then
    bird:update(dt)
  -- end

  timeSpawner = timeSpawner + dt
  if timeSpawner > 2 then
    currentY = lastY + math.random(-20, 20)
    currentY = math.min(currentY, VIRTUAL_HEIGHT - 50)
    currentY = math.max(currentY, PIPE_DIST + 50)
    timeSpawner = 0
    table.insert(PipePairs, PipePair(currentY))
    lastY = currentY
  end

  for k, v in pairs(PipePairs) do
    v:update(dt)

    -- if bird:collides(v.top) or bird:collides(v.bottom) then
    --   dead = true
    -- end
    
    if v:shouldAdd() then
      score = score + 1
    end

    if v:shouldRemove() then
      table.remove(PipePairs, k)
    end
  end
end

function Playing:render()
  love.graphics.setFont(scoreFont)
  love.graphics.printf('SCORE : ' .. tostring(score), 10, 10, VIRTUAL_WIDTH, 'left')
  bird:render()

  for k, v in pairs(PipePairs) do
    v:render()
  end
end