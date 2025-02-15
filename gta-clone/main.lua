push = require 'lib/push'
Class = require 'lib/class'

VIRTUAL_HEIGHT = 240
VIRTUAL_WIDTH = 320

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1080

player = {
    x = 40,
    y = 140,
    z = 0,
    angle = 0,
    look = 0
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

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
    if love.keyboard.keysPressed['escape'] then
        love.event.quit()
    end	

    -- testing
    if love.keyboard.isDown('left') then
        player.angle = player.angle - 10*dt
    end
    if love.keyboard.isDown('right') then
        player.angle = player.angle + 10*dt
    end
    if love.keyboard.isDown('up') then
        player.x = player.x + math.cos(player.angle)*2
        player.y = player.y + math.sin(player.angle)*2
    end
    if love.keyboard.isDown('down') then
        player.x = player.x - math.cos(player.angle)*2
        player.y = player.y - math.sin(player.angle)*2

    end
    if love.keyboard.isDown('w') then
        player.z = player.z + 1*dt
    end
    if love.keyboard.isDown('s') then
        player.z = player.z - 1*dt
    end

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply('start')

    myDraw()

    displayFPS()
    push:apply('end')
end


function myDraw() 
    calculated_cos = math.cos(player.angle)
    calculated_sin = math.sin(player.angle)
    calculated_z = tonumber((player.z+5) * 2)
    x = player.x
    y = player.y


    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle('fill', x, y, calculated_z, calculated_z)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth( 2 )
    love.graphics.line(x + calculated_z/2, y+ calculated_z/2, x + calculated_z/2+ calculated_cos *15, y+ calculated_z/2+calculated_sin*15) 
end


function displayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
