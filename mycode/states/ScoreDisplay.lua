ScoreDisplay = Class{ __includes = BaseState }

function ScoreDisplay:enter(score)
    self.score = score
end

function ScoreDisplay:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('counting')
    end
end

function ScoreDisplay:render()
    love.graphics.printf('Oof You Lost!', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Your Score is ' .. tostring(self.score), 0, 150, VIRTUAL_WIDTH, 'center')
end