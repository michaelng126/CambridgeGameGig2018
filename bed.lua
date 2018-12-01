bed_setup = {}
bed_setup.intervals = 30
bed_setup.width = 1280 / bed_setup.intervals
bed_setup.max_height = 200
bed_setup.speed = -5

bed = {}

bed_setup.cycle_pos = 0

function create_bed_block()
  local bed_block = {}
  bed_block.width = bed_setup.width
  bed_block.height = math.random(50, bed_setup.max_height)
  bed_block.cycle_pos = bed_setup.cycle_pos

  bed_setup.cycle_pos = bed_setup.cycle_pos + 1

  table.insert(bed, bed_block)
end



for i = 1, 100 do
  create_bed_block()
end

function bed_update()
end