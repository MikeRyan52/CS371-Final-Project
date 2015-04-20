local Asteroid = require 'objects.asteroid'
local Enemy = require 'objects.enemies'
local Spawn = require 'objects.spawn'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local CELL_SIZE = grid.cellSize
local composer = require 'composer'

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
	self.health = level.health
	self.money = level.money
	self.waves = level.waves
	self.grid = level.grid

	self.parentView = displayGroup
	self.uiView = uiGroup

	self.enemies = {}
	self.enemyList = {}
	self.spawnPoints = {}
	self.towers = {}

	self.menuOpen = false
	self.stopped = false
	self.updateMoney = true
	self.updateHealth = true
	self.time = 3000

	self:draw(level)
	self:renderUI(uiGroup)

	Runtime:addEventListener( 'enterFrame', self )
end

function Game:start()
	for index,spawnPoint in ipairs(self.spawnPoints) do
		spawnPoint:begin()

		self.playText:removeSelf()
		
		self.menuText = display.newText({
			text = 'Main Menu',
			width = (display.actualContentWidth / 2) - 20,
			height = 150,
			x = display.actualContentWidth - (display.actualContentWidth / 4 ) - 20,
			y = 135,
			font = native.systemFontBold,
			fontSize = 42,
			align = 'right'
		})
		self.menuText:setFillColor(0, 0.3, 0.9)
		self.uiView:insert(self.menuText)

		self.menuText:addEventListener('tap', function()
			self:stop()
			composer.gotoScene('menu.menu')
		end)
	end
end

function Game:renderUI(uiGroup)
	self.moneyText = display.newText({
		text = 'Money: ' .. self.money,
		width = (display.actualContentWidth / 2) - 20,
		height = 75,
		x = ( display.actualContentWidth / 4 ) + 20,
		y = 85,
		font = native.systemFont,
		fontSize = 32, 
		align = 'left'
	})

	self.moneyText:setFillColor(1, 1, 1)
	uiGroup:insert(self.moneyText)

	self.healthText = display.newText({
		text = 'Health: ' .. self.health,
		width = (display.actualContentWidth / 2) - 20,
		height = 75,
		x = ( display.actualContentWidth / 4 ) + 20,
		y = 130,
		font = native.systemFont,
		fontSize = 32, 
		align = 'left'
	})

	self.healthText:setFillColor(1, 1, 1)
	uiGroup:insert(self.healthText)

	self.playText = display.newText({
		text = 'Start',
		width = (display.actualContentWidth / 2) - 20,
		height = 150,
		x = display.actualContentWidth - (display.actualContentWidth / 4 ) - 20,
		y = 135,
		font = native.systemFontBold,
		fontSize = 42,
		align = 'right'
	})
	self.playText:setFillColor(0, 0.3, 0.9)
	uiGroup:insert(self.playText)

	self.playText:addEventListener('tap', function()
		self:start()
		self.playText:removeSelf()
	end)
end

function Game:draw(level)
	local x = 0
	local rects = {}

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
				rect:setFillColor( 0, 0.7, 0.3, 0.2 )
				self.parentView:insert(rect)

				if space.type == 'spawn' then
					local spawn = Spawn:new()
					spawn:init(id, space, self)
					table.insert(self.spawnPoints, spawn)
				end

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
	self.stopped = true
	Runtime:removeEventListener( 'enterFrame', self )

	for index,tower in ipairs(self.towers) do
		tower:demolish()
	end

	for index,enemy in ipairs(self.enemies) do
		enemy:dead()
	end

	for index,spawn in ipairs(self.spawnPoints) do
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
		composer.gotoScene('views.game-over')
	end
end

function Game:enterFrame()
	if not self.stopped then
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
end

return Game