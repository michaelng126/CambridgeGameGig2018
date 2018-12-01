require 'bed'

function love.load()
  math.randomseed(os.time())

  collided = false

  boat = {}
  boat.x = 800
  boat.y = 120
  boat.speed = -0.5
  boat.distance = 0

  punt = {}
  punt.x = 800
  punt.y = 50
  punt.height = 50
  punt.downward_speed = 5

  dos = {}
  dos.x = 0
  dos.y = 40

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

  boat.distance = boat.distance + 5

  if bed_setup.cycle_pos * bed_setup.width - boat.distance < 1280 then
    create_bed_block()
  end

  if #bed > bed_setup.intervals * 2 then
    table.remove(bed[1])
  end

end

function love.draw()
  love.graphics.draw(images.boat, boat.x, boat.y)
  love.graphics.draw(images.punt, punt.x, punt.y)
  love.graphics.draw(images.dos, dos.x, dos.y)

  for i = 1, #bed, 1 do
    love.graphics.rectangle('fill', bed[i].cycle_pos * bed[i].width - boat.distance, 720 - bed[i].height, bed[i].width, bed[i].height)
    if punt.x >= bed[i].cycle_pos * bed[i].width - boat.distance and punt.x >= (bed[i].cycle_pos + 1) * bed[i].width - boat.distance and punt.y + punt.height > 720 - bed[i].height then
      collided = true
      lastCollisionTime = os.time()
    else
      collided = false
    end
  end
end