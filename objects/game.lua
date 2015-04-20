local Asteroid = require 'objects.asteroid'
local Enemy = require 'objects.enemies'
local Spawn = require 'objects.spawn'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local CELL_SIZE = grid.cellSize

local Game = {
	health = 20,
	money = 10000,
	updateHealth = true,
	updateMoney = true
}

function Game:new(o)
	o = o or {}
	setmetatable(o, self);
	self.__index = self;

	return o;
end

function Game:init(levelFile, displayGroup, uiGroup)
	local level = loadLevel(levelFile)
	self.grid = level.grid
	self.parentView = displayGroup
	self.uiView = uiGroup
	self.enemies = {}
	self.enemyList = {}
	self.spawnPoints = {}
	self.towers = {}
	self.menuOpen = false
	self:draw(level)
	self:renderUI()

	Runtime:addEventListener( 'enterFrame', self )
end

function Game:renderUI()
	self.moneyText = display.newText({
		parent = self.uiGroup,
		text = 'Money: ' .. self.money,
		width = (display.actualContentWidth / 2) - 20,
		height = 150,
		x = ( display.actualContentWidth / 4 ) + 20,
		y = 150,
		font = native.systemFont,
		fontSize = 32, 
		align = 'left'
	})

	self.moneyText:setFillColor(1, 1, 1)

	self.healthText = display.newText({
		parent = self.uiGroup,
		text = 'Health: ' .. self.health,
		width = (display.actualContentWidth / 2) - 20,
		height = 150,
		x = display.actualContentWidth - ( display.actualContentWidth / 4 ) - 20,
		y = 150,
		font = native.systemFont,
		fontSize = 32, 
		align = 'right'
	})

	self.healthText:setFillColor(1, 1, 1)
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

	for index,tower in ipairs(self.towers) do
		table.remove(self.towers, index)
		tower:demolish()
	end

	for index,enemy in ipairs(self.enemies) do
		table.remove(self.enemies, index)
		enemy:dead()
	end

	for index,spawn in ipairs(self.spawnPoints) do
		table.remove(self.spawnPoints, index)
		spawn:stop()
	end
end

function Game:purchaseItem(cost)
	self.money = self.money - cost
	self.updateMoney = true
end

function Game:enemyReachedGoal(damage)
	self.health = self.health - damage
	self.updateHealth = true

	if self.health <= 0 then
		self:stop()
	end
end

function Game:enterFrame()
	if self.updateHealth then
		self.healthText.text = 'Health: ' .. self.health
	end

	if self.updateMoney then
		self.moneyText.text = 'Money: ' .. self.money
	end

	for index,tower in ipairs(self.towers) do
		if tower.destroy then
			local node = tower.node
			local id = tower.id
			table.remove(self.towers, index)
			tower:demolish()

			local meteor = Asteroid:new()
			meteor.xLocation = grid.x(node.column)
			meteor.yLocation = grid.y(node.row)
			meteor:spawn(id, node, self)
		elseif not tower.fired then
			tower:target(self.enemies)
		end
	end

	for index,enemy in ipairs(self.enemies) do
		if enemy.atGoal then
			self:enemyReachedGoal(enemy.damage)
		end

		if enemy.destroy then
			table.remove(self.enemies, index)
			enemy:dead()
			if not enemy.atGoal then 
				self:purchaseItem(-1 * enemy.value)
			end
		end
	end
end

return Game