local Object = require "libraries/classic"
local Bunny = Object:extend()

function Bunny:new(game)
    self.game = game
    self.bunny = love.graphics.newImage("assets/bun.png")
    self.width = 50
    self.height = 50
    self.floor = game.floor - self.height
    self.x = love.graphics.getWidth()/3 - self.width/2
    self.y = self.floor
    self.acceleration = 1500
    self.velocity = 0
    self.jumpForce = 500
    self.maxJump = 5
    self.jumpCount = self.maxJump
    self.spacePressed = false
end

function Bunny:update(dt)
    self:applyGravity(dt)
    if self.game.gameOver == false then
        self:jump(dt)
    end
end

function Bunny:draw()
    love.graphics.draw(self.bunny, self.x, self.y)
end

function Bunny:applyGravity(dt)
    self.velocity = self.velocity + self.acceleration * dt
    self.y = self.y + self.velocity * dt

    if self.y >= self.floor then
        self.y = self.floor
        self.velocity = 0
        self.jumpCount = self.maxJump
    end
end

function Bunny:jump(dt)
    if love.keyboard.isDown("space") 
        and self.spacePressed == false
        and self.jumpCount > 0 then
        self.spacePressed = true
        self.jumpCount = self.jumpCount - 1
        self.velocity = -self.jumpForce
    end

    if love.keyboard.isDown("space") == false then
        self.spacePressed = false
    end
end

return Bunny