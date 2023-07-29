push = require 'libraries/push'
class = require 'libraries/class'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288

local BACKGROUND_LOOPING_POINT = 413
local BACKGROUND_SPEED = 30
local background = love.graphics.newImage('pictures/background.png')
local backgroundScroll = 0

local GROUND_SPEED = 60
local ground = love.graphics.newImage('pictures/ground.png')
local groundScroll = 0

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('flappy bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = false
    })
end

function love.resize(w, h) 
    push:resize(w, h)
end

function love.update(dt) 
    backgroundScroll = (backgroundScroll + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SPEED * dt) % VIRTUAL_WIDTH
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end