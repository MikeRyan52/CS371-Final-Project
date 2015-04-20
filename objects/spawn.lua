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
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		},
		{
			shipType1 = 5,
			shipType2 = 5,
			shipType3 = 5
		}
	}
	self.game = game

	local index = 1
	local function wave()
		for shipType,count in pairs(self.enemies[index]) do
			local function spawn()
				local enemy = Enemy:new()
				enemy.xSpawn = grid.x(node.column)
				enemy.ySpawn = grid.y(node.row)

				enemy:spawn(game, self.id)
			end

			local time = 0
			while count > 0 do
				time = time + 300
				timer.performWithDelay(time, spawn)
				count = count - 1
			end
		end
		index = index + 1
	end

	wave()
	timer.performWithDelay(15000, wave, 10)
end

return Spawn