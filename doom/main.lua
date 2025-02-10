require 'src/Dependencies'

--[[
    Called just once at the beginning of the game; used to set up
    game objects, variables, etc. and prepare the game world.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:apply('start')

    -- hello wolrd
    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')    


    for y = 0, VIRTUAL_HEIGHT - 1 do
        for x = 0, VIRTUAL_WIDTH - 1 do
            if x == 0 or x == VIRTUAL_WIDTH - 1 or y == 0 or y == VIRTUAL_HEIGHT - 1 then
                pixel(x, y, "yellow")
            else
                pixel(x, y, "blue")
            end
        end
    end

    for x = 0, 100 do
        pixel(x, x, "red")
    end

    displayFPS()
    push:apply('end')
end


function pixel(x, y, c)
    if c == "yellow" then
        love.graphics.setColor(1, 1, 0, 1)
    elseif c == "red" then
        love.graphics.setColor(1, 0, 0, 1)
    elseif c == "green" then
        love.graphics.setColor(0, 1, 0, 1)
    elseif c == "blue" then
        love.graphics.setColor(0, 0, 1, 1)
    else
        love.graphics.setColor(0, 60/255, 130/255, 1)
    end
    love.graphics.rectangle('fill', x, y, 1, 1)
end

--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

