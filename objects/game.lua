local Asteroid = require 'objects.asteroid'
local Enemy = require 'objects.enemies'
local Spawn = require 'objects.spawn'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local CELL_SIZE = grid.cellSize

local Game = {
	health = 20,
	money = 250,
	updateHealth = true,
	updateMoney = true
}

function Game:new(o)
	o = o or {}
	setmetatable(o, self);
	self.__index = self;

	return o;
end

function Game:init(levelFile, displayGroup)
	local level = loadLevel(levelFile)
	self.grid = level.grid
	self.parentView = displayGroup
	self.enemies = {}
	self.enemyList = {}
	self.spawnPoints = {}
	self.towers = {}
	self:draw(level)

	Runtime:addEventListener( 'enterFrame', self )
end

function Game:draw(level)
	local x = 0
	while x <= 30 do
		local y = 0
		while y <= 50 do
			local id = y .. ',' .. x

			if level.grid[id] then
				local space = level.grid[id]
				local rect = display.newRect(
					grid.x(space.column),
					grid.y(space.row),
					CELL_SIZE,
					CELL_SIZE
				)

				if space.type == 'path' then
					rect:setFillColor( 0, 0, 200, 0.5 )
				elseif space.type == 'spawn' then
					rect:setFillColor( 200, 0, 0, 0.5 )
					local spawn = Spawn:new()
					spawn:init(id, space, self)
					table.insert(self.spawnPoints, spawn)
				elseif space.type == 'goal' then
					rect:setFillColor( 0, 200, 0, 0.5 )
				elseif space.type == 'tower' then
					rect:setFillColor( 0, 200, 0, .5 )
				end

				self.parentView:insert(rect)

			elseif level.towers[id] then
				local space = level.towers[id]
				local rect = display.newRect(
					grid.x(space.column),
					grid.y(space.row),
					CELL_SIZE,
					CELL_SIZE
				)
				rect:setFillColor( 1, 1, 1, 0.7 )
				self.parentView:insert(rect)

				local tower = Asteroid:new()

				tower.xLocation = grid.x(space.column)
				tower.yLocation = grid.y(space.row)

				tower:spawn(id, space, self)
			end


			y = y + 1
		end
		x = x + 1
	end
end

function Game:getEnemies()
	return self.enemies
end

function Game:stop()
	Runtime:removeEventListener( 'enterFrame', self )
end

function Game:purchaseItem(event)
	self.money = self.money - event.cost
	self.updateMoney = true
end

function Game:enemyReachedGoal(event)
	self.health = self.health - event.damage
	self.updateHealth = false
end

function Game:enterFrame()
	if self.updateHealth then

	end

	for index,tower in ipairs(self.towers) do
		if tower.destroy then
			table.remove(self.towers, index)
		elseif not tower.fired then
			tower:target(self.enemies)
		end
	end

	for index,enemy in ipairs(self.enemies) do
		if enemy.destroy then
			table.remove(self.enemies, index)
		end
	end
end

return Game