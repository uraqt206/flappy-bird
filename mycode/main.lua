push = require 'mycodee.libraries.push'
Class = require 'mycodee.libraries.class'
require 'mycodee.libraries.StateMachine'
require 'mycodee.objects.Bird'
require 'mycodee.objects.Pipe'
require 'mycodee.objects.PipePair'
require 'mycodee.states.BaseState'
require 'mycodee.states.Title'
require 'mycodee.states.Playing'

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
        ['playing'] = function() return Playing() end,
    }
    gStateMachine:change('title')

    mediumFont = love.graphics.newFont('fonts/font.ttf', 16)
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