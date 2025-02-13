Player = Class{}

function Player:init(x, y, z, angle, look)
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8
    self.z = 0
    self.angle = 0 
    self.look = 0

    self.dx = 0
    self.dy = 0
end


function Player:update(dt)
    if love.keyboard.isDown('a') and not love.keyboard.isDown('m') then
        self.angle = self.angle - math.pi/45 * dt
    end
    if love.keyboard.isDown('d') and not love.keyboard.isDown('m') then
        self.angle = self.angle + math.pi/45 * dt
    end

    self.dx=math.sin(self.angle)*10.0;
    self.dy=math.cos(self.angle)*10.0;

    if love.keyboard.isDown('w') and not love.keyboard.isDown('m') then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end

    if love.keyboard.isDown('s') and not love.keyboard.isDown('m') then
        self.x = self.x - self.dx *dt
        self.y = self.y - self.dy *dt
    end

    -- strafe left and right    
    if love.keyboard.isDown('q') then
        self.x = self.x - self.dy *dt
        self.y = self.y + self.dx *dt
    end
    if love.keyboard.isDown('e') then
        self.x = self.x + self.dy *dt
        self.y = self.y - self.dx *dt
    end

    -- moveup, down, look up and dow
    if love.keyboard.isDown('a') and love.keyboard.isDown('m') then
        self.look = self.look - 1*dt 
    end
    if love.keyboard.isDown('d') and love.keyboard.isDown('m') then
        self.look = self.look + 1*dt 
    end
    if love.keyboard.isDown('w') and love.keyboard.isDown('m') then
        self.z = self.z - 4*dt
    end
    if love.keyboard.isDown('s') and love.keyboard.isDown('m') then
        self.z = self.z + 4*dt
    end


    -- fix angle
    if self.angle > math.pi * 2 then
        self.angle = self.angle - math.pi * 2
    end
    if self.angle < 0 then
        self.angle = self.angle + math.pi * 2
    end
end

-- function Bird:render()
--     love.graphics.draw(self.image, self.x, self.y)
-- end