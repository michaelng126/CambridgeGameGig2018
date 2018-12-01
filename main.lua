function love.load()
    boat = {}
    boat.x = 1000
    boat.y = 40
    boat.speed = -2
    boat.distance = 0

    pole = {}
    pole.x = 1000
    pole.y = 50
    pole.downward_speed = 0

    dos = {}
    dos.x = 0
    dos.y = 40

    beds = {}
    beds.speed = -5

    collided = false

    -- Assets --
    images = {}
    images.boat = love.graphics.newImage("assets/boat.png")
    images.pole = love.graphics.newImage("assets/pole.png")
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

end

function love.draw()
  love.graphics.draw(images.boat, boat.x, boat.y)
  love.graphics.draw(images.pole, pole.x, pole.y)
  love.graphics.draw(images.dos, dos.x, dos.y)

end

-- Returns a boolean type variable telling whether the end of the pole touches the riverbed
-- Takes two tables as arguments, ie., bed{} and pole{}
function collide(a, b)
  if 1 == 0 then
    lastCollisionTime = os.time()
    return true
  else
    return false
  end

end