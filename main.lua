require 'bed'

function love.load()
  gameover = false
  lastCollisionTime = 0
  math.randomseed(os.time())

  collided = false

  boat = {}
  boat.x = 800
  boat.y = 120
  boat.speed = -50
  boat.distance = 0

  pole = {}
  pole.x = 800
  pole.y = 50
  pole.height = 50
  pole.downward_speed = 0

  dos = {}
  dos.x = 0
  dos.y = 40

  -- Assets --
  images = {}
  images.boat = love.graphics.newImage("assets/boat.png")
  images.pole = love.graphics.newImage("assets/pole.png")
  images.dos = love.graphics.newImage("assets/dos.png")
  images.sky = love.graphics.newImage("assets/sky.jpeg")

  fonts = {}
  fonts.score = love.graphics.newFont("assets/Gamer.ttf",36)
	fonts.teaser = love.graphics.newFont("assets/Gamer.ttf",50)
	fonts.gameover = love.graphics.newFont("assets/Gamer.ttf", 120)
	fonts.gm = love.graphics.newFont("assets/Gamer.ttf", 300)
end

function love.update(dt) -- called 60 times per second typically by default
    -- if collision happens, speed up the boat

    if (os.time()-lastCollisionTime >= 1) then
        boat.speed = -100
    end

    if boat.x < 50 then
      gameover = true
    end

    -- Update of pole.y
    if (os.time()-lastCollisionTime >= 1) then
      if love.keyboard.isDown('space') then
          pole.downward_speed = 500
          pole.y = pole.y + pole.downward_speed*dt
      end
    else
      if pole.y > 50 then
          pole.downward_speed = -2000
          if pole.y + pole.downward_speed*dt <= 50 then
              pole.y = 50
              pole.downward_speed = 0
          else
              pole.y = pole.y + pole.downward_speed*dt
          end
      end
    end

    -- Update the x positions of both boat and pole
    boat.x = math.min(boat.x + boat.speed*dt, 1200)
    pole.x = math.min(pole.x + boat.speed*dt, 1200) -- pole moves backwards together with the boat
    boat.distance = boat.distance + 5*dt

  boat.distance = boat.distance + 5

  if bed_setup.cycle_pos * bed_setup.width - boat.distance < 1280 then
    create_bed_block()
  end

  if #bed > bed_setup.intervals * 2 then
    table.remove(bed[1])
  end

end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(images.sky,0,0)

  love.graphics.setColor(255,255,255)
  love.graphics.draw(images.boat, boat.x, boat.y)

  love.graphics.setColor(15, 59, 130)
  love.graphics.rectangle('fill', 0, 200, 1280, 720)

  love.graphics.setColor(255,255,255)
  love.graphics.draw(images.pole, pole.x, pole.y)
  love.graphics.draw(images.dos, dos.x, dos.y)

  love.graphics.setColor(155, 59, 74)
  for i = 1, #bed, 1 do
    love.graphics.rectangle('fill', bed[i].cycle_pos * bed[i].width - boat.distance, 720 - bed[i].height, bed[i].width, bed[i].height)
    if pole.x >= bed[i].cycle_pos * bed[i].width - boat.distance and pole.x >= (bed[i].cycle_pos + 1) * bed[i].width - boat.distance and pole.y + pole.height > 720 - bed[i].height then
      if os.time()-lastCollisionTime >= 1 then
        collided = true
        boat.speed = 200
        lastCollisionTime = os.time()
      end
    else
      collided = false
    end
  end

  love.graphics.setFont(fonts.score)
	love.graphics.print(math.floor(boat.distance / 10), 30, 5)

  if gameover then
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(fonts.gm)
		love.graphics.print("GAME OVER", 150, 300)
	end

end

function love.keypressed(key)
  if gameover then
		love.load()
  end
end