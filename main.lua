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

function love.update(dt) -- called 60 times per second typically by default
    -- if collision happens, speed up the boat
    if collided then 
        collided = false
        boat.speed = 30
    end

    if (os.time()-lastCollisionTime >= 2) and (os.time()-lastCollisionTime <=5) then
        boat.speed = 0
    elseif os.time()-lastCollisionTime > 5 then
            boat.speed = -2
    end
 
    
    -- Update of pole.y 
    if (love.keyboard.isDown('space') and (collide(bed{}, pole{})==false)) then
        pole.downward_speed = 5 
        pole.y = pole.y + pole.downward_speed*dt
    elseif ((love.keyboard.isDown('space')==false) and pole.y>50) then 
        pole.downward_speed = -10
        if pole.y + pole.downward_speed*dt <= 50 then
            pole.y = 50
        else
            pole.y = pole.y + pole.downward_speed*dt
        end
    end

    -- Update the x positions of both boat and pole
    boat.x = boat.x + boat.speed*dt
    pole.x = pole.x + boat.speed*dt -- pole moves backwards together with the boat
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
  love.graphics.draw(images.boat, boat.x, boat.y)
  love.graphics.draw(images.pole, pole.x, pole.y)
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