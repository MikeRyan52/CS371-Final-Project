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
	self.id = id
	self.node = node
	self.enemies = game.enemyList[id] or {
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		},
		{
			shipType1 = 5,
			shipType2 = 3,
			shipType3 = 1
		}
	}

	self.game = game

	self:createWaves()
	self:begin()
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

<<<<<<< HEAD
			time = time + 900

			timer.performWithDelay(time, spawn)
=======
			local time = 0
			while count > 0 do
				time = time + 300
				timer.performWithDelay(time, spawn)
				count = count - 1
			end
>>>>>>> 377f8e29a53856077f1e3d1d5ce15bfa83ae0930
		end
		index = index + 1
	end

	self.timerRef = timer.performWithDelay(30000, wave, 10)
end

function Spawn:stop()
	timer.cancel(self.timerRef)
end

return Spawn