local json = require 'json'

local Tower = {
	frame = 1, 
	xLocation = display.contentCenterX, 
	yLocation = display.contentCenterY, 
	cost = 300,
	value = 100,
	radius = 4,
	fireSpeed = 300,
	damage = 10,
	towertype = "damage"
}

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
		{x = 75, y = 0, width = 75, height = 68}, --frame 2 of aoe, cost = 350, value = 300, radius = 4, fireSpeed = 150, damage = 20
		{x = 150, y = 0, width = 75, height = 68},	--frame 3 of aoe, cost = 400, value = 500, radius = 4, fireSpeed = 350, damage = 20
	}
}


function Tower:spawn(game, type, id, node)
	self.menuOpen = false
	self.parentView = game.parentView
	self.type = type
	self.game = game
	self.node = node
	self.destroy = false

	self.targetNodes = {}

	self:draw()
	self:findNodes()
	self:target()
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
		local fDist = first.distance or 0
		local sDist = second.distance or 0

		return fDist <= sDist
	end)

	self.nodes = nodes
end

function Tower:target()
	local targetEnemy = false

	for index,node in ipairs(self.nodes) do
		for index,enemy in ipairs(self.game.enemies) do
			if enemy.nodeId == node.id then
				targetEnemy = enemy
				break
			end
		end

		if targetEnemy then break end
	end

	if targetEnemy then 
		targetEnemy:hit(500) 

		local deltaY = self.shape.y - targetEnemy.shape.y
		local deltaX = self.shape.x - targetEnemy.shape.x
		self.shape.rotation = ((math.atan2(deltaY, deltaX) * 180) / math.pi ) + 270

		targetEnemy = false
	end

	self.targetRef = timer.performWithDelay(self.fireSpeed, function()
		self:target()
	end)
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
	self.shape.xScale = 1
	self.shape.yScale = 1
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”

	self.parentView:insert(self.shape)
	self.shape:addEventListener("tap", self)
end

function Tower:tap()
	if not self.menuOpen then
		local menu = display.newImage('towermenu.png', self.shape.x, self.shape.y + 40)

		menu.xScale = 0.6
		menu.yScale = 0.6
		self.menuOpen = true

		local function zoneHandler(event)
			local x,y = event.target:contentToLocal(event.x, event.y)
			x = x + 225
			y = y + 225
			x = math.ceil( x / 150 )
			y = math.ceil( y / 150 )
			print(x,y)
			if ((x == 2 and y == 1) or (x == 3 and y == 1)) then 
				self:upgrade()
			elseif  ((x == 0 and y == 3) or (x == 1 and y == 2) or (x == 2 and y == 2) or (x == 2 and y == 3) or (x == 1 and y == 3)) then
				self:sell()
			end

			menu:removeSelf()
			self.menuOpen = false
		end

		menu:addEventListener('tap', zoneHandler)
	end
end

function Tower:upgrade()
	local function regenerate(frame)
		self.shape:removeSelf()
		self.frame = frame
		self:spawn()
	end

	if self.frame == 1 then
		regenerate(2)
	elseif self.frame == 2 then
		regenerate(3)
	elseif self.frame == 4 then
		regenerate(5)
	elseif self.frame == 5 then
		regenerate(6)
	elseif self.frame == 7 then
		regenerate(8)
	elseif self.frame == 8 then
		regenerate(9)
	end
end

function Tower:sell ()
	self.destroy = true
end

return Tower