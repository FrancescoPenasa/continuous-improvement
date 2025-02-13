require 'src/Dependencies'



-- what i might need
-- love.keyboard.wasPressed('space') then
-- love.keyboard.isDown('left') then


--[[
    Called just once at the beginning of the game; used to set up
    game objects, variables, etc. and prepare the game world.
]]
function love.load()
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}

    player = Player(70 , -110, 20, 0, 0) 
end

function love.resize(w, h)
    push:resize(w, h)
end

local tickPeriod = 1/60 -- seconds per tick
local accumulator = 0.0

function love.update(dt)
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end	
    --  move player
    player:update(dt)

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

    -- love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')    

    draw3d()

    displayFPS()
    displayPlayer()
    push:apply('end')
end

function draw3d() 
    cs = math.cos(player.angle)
    sn = math.sin(player.angle)

    -- wall coordinates respect to the player
    x1=40-player.x
    y1=140-player.y
    x2=40-player.x
    y2=200-player.y


    -- position
    wx0 = x1*cs-y1*sn
    wx1 = x2*cs-y2*sn

    --  depth
    wy0 = y1*cs+x1*sn
    wy1 = y2*cs+x2*sn 

    -- height
    wz0 = 0- player.z + ((player.look-wy0)/32.0)
    wz1 = 0- player.z + ((player.look-wy1)/32.0)


    -- screen coordinates
    wx0 = wx0*200/wy0+VIRTUAL_WIDTH/2
    wy0 = wz0*200/wy0+VIRTUAL_HEIGHT/2
    wx1 = wx1*200/wy1+VIRTUAL_WIDTH/2
    wy1 = wz1*200/wy1+VIRTUAL_HEIGHT/2

    if(wx0 > 0 and wx0 < VIRTUAL_WIDTH and wy0>0 and wy0<VIRTUAL_HEIGHT) then
        pixel(wx0, wy0, "yellow")
    end
    if(wx1 > 0 and wx1 < VIRTUAL_WIDTH and wy1>0 and wy1<VIRTUAL_HEIGHT) then
        pixel(wx1, wy1, "green")
    end

    
end

function clearBackground() 
    love.graphics.clear(0, 0, 0, 1)
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

function displayPlayer()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Player: ' .. tostring(math.floor(player.x)) .. " " .. tostring(math.floor(player.y)) .. " " .. tostring(math.floor(player.z)) .. " " .. tostring(player.angle) .. " " .. tostring(player.look), 5, 15)
end