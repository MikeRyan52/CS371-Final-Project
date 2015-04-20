local Enemy = require 'objects.enemies'
local grid = require 'utilities.grid'

local Spawn = {
	
}

function Spawn:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Spawn:init(id, node, game)
	self.timers = {}
	self.id = id
	self.node = node
	self.enemies = game.waves 

	self.game = game

	self:createWaves()
end

function Spawn:createWaves()
	math.randomseed( os.time() )

	local function shuffleTable( t )
	    local rand = math.random 
	    local iterations = #t
	    local j
	    
	    for i = iterations, 2, -1 do
	        j = rand(i)
	        t[i], t[j] = t[j], t[i]
	    end

	    return t
	end

	local waves = {}
	
	for index,wave in ipairs(self.enemies) do
		local targetWave = {}

		for shipType, count in pairs(wave) do
			local i = 1;

			while i <= count do
				table.insert(targetWave, shipType)
				i = i + 1
			end
		end

		table.insert(waves, shuffleTable(targetWave))
	end

	self.waves = waves;
end

function Spawn:begin()
	local index = 1

	local function wave()
		local time = 0
		for index,shipType in ipairs(self.waves[index]) do
			local function spawn()
				local enemy = Enemy:new()
				enemy.xSpawn = grid.x(self.node.column)
				enemy.ySpawn = grid.y(self.node.row)

				enemy:spawn(self.game, self.id, shipType)
				table.insert(self.game.enemies, enemy)
			end

			time = time + 900

			table.insert(self.timers, timer.performWithDelay(time, spawn))
		end
		index = index + 1
	end

	wave()
	self.timerRef = timer.performWithDelay(30000, wave, 9)
end

function Spawn:stop()
	timer.cancel(self.timerRef)
	for index,timerRef in ipairs(self.timers) do
		timer.cancel(timerRef)
	end
end

return Spawn