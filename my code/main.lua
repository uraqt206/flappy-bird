push = require 'libraries/push'
Class = require 'libraries/class'
require 'objects/Bird'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288

local BACKGROUND_LOOPING_POINT = 413
local BACKGROUND_SPEED = 30
local background = love.graphics.newImage('pictures/background.png')
local backgroundScroll = 0

local GROUND_SPEED = 60
local ground = love.graphics.newImage('pictures/ground.png')
local groundScroll = 0

bird = Bird()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('flappy bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = false
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h) 
    push:resize(w, h)
end

function love.keypressed(key) 
    if key == 'escape' then
        love.event.quit();
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key) 
    return love.keyboard.keysPressed[key]
end

function love.update(dt) 
    backgroundScroll = (backgroundScroll + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SPEED * dt) % VIRTUAL_WIDTH
    bird:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
    
    push:finish()
end