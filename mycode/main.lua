push = require 'libraries/push'
Class = require 'libraries/class'
require 'libraries/StateMachine'
require 'objects/Bird'
require 'objects/Pipe'
require 'objects/PipePair'
require 'states/BaseState'
require 'states/Title'
require 'states/CountingDown'
require 'states/Playing'
require 'states/ScoreDisplay'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288

PIPE = love.graphics.newImage('pictures/pipe.png')
PIPE_WIDTH = PIPE:getWidth()
PIPE_HEIGHT = PIPE:getHeight()
PIPE_SPEED = 60
PIPE_DIST = 120

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

    math.randomseed(os.time())

    love.keyboard.keysPressed = {}

    gStateMachine = StateMachine {
        ['title'] = function() return Title() end,
        ['counting'] = function() return CountingDown() end,
        ['playing'] = function() return Playing() end,
        ['score'] = function() return ScoreDisplay() end,
    }
    gStateMachine:change('title')

    mediumFont = love.graphics.newFont('fonts/font.ttf', 16)
    giantFont = love.graphics.newFont('fonts/flappy.ttf', 60)
    scoreFont = love.graphics.newFont('fonts/flappy.ttf', 32)
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
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render();
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end