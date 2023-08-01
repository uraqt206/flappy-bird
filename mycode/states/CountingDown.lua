CountingDown = Class { __includes = BaseState }

function CountingDown:init()
    self.TIME_UNIT = 0.75
    self.timer = 0
    self.timeLeft = 3
end

function CountingDown:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.TIME_UNIT then
        if self.timeLeft == 0 then
            gStateMachine:change('playing')
        end
        self.timeLeft = self.timeLeft - 1
        self.timer = 0
    end
end

function CountingDown:render()
    love.graphics.setFont(giantFont)
    love.graphics.printf(tostring(self.timeLeft), 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
end