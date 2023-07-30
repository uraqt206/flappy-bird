push = require 'libraries/push'
Class = require 'libraries/class'
require 'objects/Bird'
require 'objects/Pipe'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288

local BACKGROUND_LOOPING_POINT = 413
local BACKGROUND_SPEED = 30
local background = love.graphics.newImage('pictures/background.png')
local backgroundScroll = 0

local GROUND_SPEED = 60
local ground = love.graphics.newImage('pictures/ground.png')
local groundScroll = 0

local timeSpawner = 0

bird = Bird()
pipes = {}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('flappy bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true
    })

    math.randomseed(os.time())

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

    timeSpawner = timeSpawner + dt
    if timeSpawner > 2 then
        table.insert(pipes, Pipe())
        timeSpawner = 0
    end

    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if pipe.x < -PIPE_WIDTH then
            table.remove(pipes, k) 
        end
    end
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    for k, pipe in pairs(pipes) do
        pipe:render()
    end
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
    
    push:finish()
end