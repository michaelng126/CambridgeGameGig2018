bed_setup = {}
bed_setup.intervals = 200
bed_setup.width = 1280 / bed_setup.intervals
bed_setup.max_height = 200
bed_setup.speed = -5
bed_setup.variation = 3

bed = {}

bed_setup.cycle_pos = 0
bed_setup.previous = 100

function clip(x, min, max)
  if x > max then return max
  elseif x < min then return min
  else return x end
end

function create_bed_block()
  local bed_block = {}
  bed_block.width = bed_setup.width
  bed_block.height = clip(bed_setup.previous + math.random(-1 * bed_setup.variation, bed_setup.variation), 0, 200)
  bed_setup.previous = bed_block.height
  bed_block.cycle_pos = bed_setup.cycle_pos

  bed_setup.cycle_pos = bed_setup.cycle_pos + 1

  table.insert(bed, bed_block)
end

for i = 1, bed_setup.intervals do
  create_bed_block()
end