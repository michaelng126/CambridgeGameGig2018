function love.load()
  boat = {}
  boat.x = 200
  boat.y = 40
  boat.speed = -2

  punt = {}
  punt.x = 200
  punt.y = 50
  punt.downward_speed = 0

  dos = {}
  dos.x = 0
  dos.y = 40

  beds = {}
  beds.speed = -5

  -- Assets --
  images = {}
  images.boat = love.graphics.newImage("assets/boat.png")
  images.punt = love.graphics.newImage("assets/punt.png")
  images.dos = love.graphics.newImage("assets/dos.png")
end

function love.update()
  boat.x = boat.x + boat.speed
  punt.x = punt.x + boat.speed -- punt moves back with boat
  punt.y = punt.y + punt.downward_speed

end

function love.draw()
  love.graphics.draw(images.boat, boat.x, boat.y)
  love.graphics.draw(images.punt, punt.x, punt.y)
  love.graphics.draw(images.dos, dos.x, dos.y)

end

function collide(a, b)
  if 1 == 1 then
    return true
  else
    return false
  end
end