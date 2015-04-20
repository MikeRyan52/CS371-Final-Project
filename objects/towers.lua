local json = require 'json'
local TowerTypes = require 'utilities.tower-types'
local laser = require 'effects.laser'
local bloom = require 'effects.bloom'
local explode = require 'effects.explode'

local Tower = {
	frame = 1, 
	xLocation = display.contentCenterX, 
	yLocation = display.contentCenterY, 
	value = 100,
	radius = 4,
	damage = 50,
	fireSpeed = 300,
	towertype = "damage"
};

function Tower:new (o) --constructor
	o = o or {};

	setmetatable(o, self);
	self.__index = self;
	return o;
end

local opt = 
{

	frames = { 
		{x = 275, y = 0, width = 75, height =68},	--frame 1
		{x = 275, y = 68, width = 75, height = 68}, --frame 2, cost = 300, value = 200, radius = 5, fireSpeed = 300, damage = 40
		{x= 275, y = 135, width = 80, height = 68}, --frame 3, cost = 300, value = 300, radius = 6, fireSpeed = 350, damage = 80
		
		{x = 195, y = 0, width = 75, height =68},	--frame 4, cost = 200, value = 50, radius = 3, fireSpeed = 350, damage = 5
		{x = 195, y = 68, width = 75, height = 68}, --frame 5, cost = 200, value = 100, radius = 4, fireSpeed = 400, damage = 20
		{x= 202, y = 135, width = 75, height = 68}, --frame 6, cost = 400, value = 400, radius = 5, fireSpeed = 600, damage = 20
		
		{x = 120, y = 0, width = 75, height =68},	--frame 7
		{x = 135, y = 68, width = 60, height = 68}, --frame 8
		{x= 135, y = 135, width = 70, height = 68}, --frame 9
	}
}
local opt2 = 
{

	frames = {
		{x = 0, y=0, width = 69, height = 68}, --frame 1 of aoe Tower, cost = 400, value = 200, radius = 3, firespeed = 150, damage = 5
		{x = 62, y = 0, width = 69, height = 68}, --frame 2 of aoe, cost = 350, value = 300, radius = 4, fireSpeed = 150, damage = 20
		{x = 125, y = 0, width = 69, height = 68},	--frame 3 of aoe, cost = 400, value = 500, radius = 4, fireSpeed = 350, damage = 20
	}
}

function Tower:spawn(game, type, id, node)
	self.track = 1
	self.menuOpen = false
	self.parentView = game.parentView
	self.type = type
	self.game = game
	self.node = node
	self.fired = false;
	self.destroy = false;

	self.targetNodes = {}

	self:setStats()
	self:draw()
	self:findNodes()
end

function Tower:setStats()
	if self.track <= 3 then
		local stats = TowerTypes[self.type][self.track]

		self.frame = stats.frame
		self.radius = stats.radius
		self.fireSpeed = stats.fireSpeed
		self.damage = stats.damage
	end
end

function Tower:upgrade()
	local nextTrack = self.track + 1
	if nextTrack > 3 then nextTrack = 3 end

	local cost = TowerTypes[self.type][nextTrack].cost

	if self.track < 3 and self.game.money >= cost then
		self.shape:removeSelf()
		self.track = self.track + 1
		self:setStats()
		self:draw()
		self:findNodes()
		self.game:purchaseItem(cost)
	end
end

function Tower:findNodes()
	local x = self.node.column - self.radius
	local targetCol = self.node.column + self.radius

	while x <= targetCol do
		local y = self.node.row - self.radius
		local targetRow = self.node.row + self.radius
		while y <= targetRow do
			table.insert(self.targetNodes, y .. ',' .. x)

			y = y + 1
		end

		x = x + 1
	end

	local nodes = {}

	for index,id in ipairs(self.targetNodes) do
		if self.game.grid[id] then 
			local space = self.game.grid[id]
			space.id = id
			table.insert(nodes, space)
		end
	end

	table.sort(nodes, function(first, second)
		if first == nil and second == nil then
			return false
		elseif first == nil then
			return true
		elseif second == nil then
			return false
		else
			return first.distance < second.distance
		end
	end)

	self.nodes = nodes
end

function Tower:target(enemies)
	if self.type == 'laser' then
		local targetEnemy = false

		for index,node in ipairs(self.nodes) do
			for index,enemy in ipairs(enemies) do
				if enemy.nodeId == node.id and not enemy.exploding then
					targetEnemy = enemy 
					break
				end
			end

			if targetEnemy then break end
		end

		if targetEnemy then 
			targetEnemy:hit(self.damage) 

			self:point(targetEnemy)

			laser(self.game.parentView, self.shape, targetEnemy.shape)

			self.shape:toFront()

			targetEnemy = false
		end
	elseif self.type == 'cannon' then

		for index,node in ipairs(self.nodes) do
			local found = false

			for index,enemy in ipairs(enemies) do
				if enemy.nodeId == node.id and not enemy.exploding then
					if not found then
						self:point(enemy)
					end
					enemy:hit(self.damage)
					found = enemy
				end
			end
			if found then
				explode(self.game.parentView, self.shape, found.shape, self.radius)
				self.shape:toFront()
				break
			end
		end

	elseif self.type == 'aoe' then
		local found = false

		for index,node in ipairs(self.nodes) do
			for index, enemy in ipairs(enemies) do
				if enemy.nodeId == node.id and not enemy.exploding then
					enemy:hit(self.damage)
					found = true
				end
			end
		end

		if found then
			bloom(self.game.parentView, self.shape, self.radius)
			self.shape:toFront()
		end

	end


	self.fired = true

	timer.performWithDelay(self.fireSpeed, function() 
		self.fired = false
	end)
end

function Tower:point(enemy)
	local deltaY = self.shape.y - enemy.shape.y
	local deltaX = self.shape.x - enemy.shape.x
	self.shape.rotation = ((math.atan2(deltaY, deltaX) * 180) / math.pi ) + 270
end

function Tower:draw()
	local sheet = graphics.newImageSheet( "towersheetone.png", opt)
	local sheet2 = graphics.newImageSheet( "towersheettwo.png", opt2 )

	if self.type == 'aoe' then
		self.shape = display.newImage( sheet2, self.frame)
	else
		self.shape = display.newImage( sheet, self.frame )
	end

	self.shape.x = self.xLocation
	self.shape.y = self.yLocation
	self.shape.xScale = 1.5
	self.shape.yScale = 1.5
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”

	self.parentView:insert(self.shape)
	self.shape:addEventListener("tap", self)
end

function Tower:tap()
	if not self.game.menuOpen then
		local menu = display.newImage('towermenu.png', self.shape.x, self.shape.y + 40)
		self.game.parentView:insert(menu)
		menu.xScale = 0.6
		menu.yScale = 0.6
		self.game.menuOpen = true

		local function zoneHandler(event)
			local x,y = event.target:contentToLocal(event.x, event.y)
			x = x + 225
			y = y + 225
			x = math.ceil( x / 150 )
			y = math.ceil( y / 150 )

			if ((x == 2 and y == 1) or (x == 3 and y == 1)) then 
				self:upgrade()
			elseif  ((x == 0 and y == 3) or (x == 1 and y == 2) or (x == 2 and y == 2) or (x == 2 and y == 3) or (x == 1 and y == 3)) then
				self:sell()
			end

			menu:removeSelf()
			timer.performWithDelay(10, function()
				self.game.menuOpen = false
			end)
		end

		menu:addEventListener('tap', zoneHandler)
	end
end



function Tower:sell ()
	self.destroy = true;
end

function Tower:demolish()
	self.shape:removeSelf()
end

return Tower