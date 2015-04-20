local grid = require 'utilities.grid'

local Enemies = {
	frame=1, 
	xSpawn = display.contentCenterX, 
	ySpawn = display.contentCenterY, 
	HP = 240,
	speed = 200
}


function Enemies:new (o) --constructor
	o = o or {};

	setmetatable(o, self);
	self.__index = self;
	return o;
end

local opt = 
{

	frames = { 
		{x = 100, y = 65, width = 25, height =30},--frame 1, value 75 
		{x = 60, y = 35, width = 35, height = 30}, --frame 2, HP 80, speed 400, 50 
		{x= 94, y = 35, width = 35, height = 30}, --frame 3, HP 800, speed 50, 150
		{x = 190, y = 224, width = 35, height = 30}, --frame 4
		{x = 225, y = 219, width = 35, height = 30}, --frame 5
	}
}

local sheet = graphics.newImageSheet( "spaceships2.png", opt)
function Enemies:spawn(game, startingId)
	self.game = game
	self.startingId = startingId
	self.nodeId = startingId;
	self.shape= display.newImage( sheet, self.frame)
	self.shape.x = self.xSpawn
	self.shape.y = self.ySpawn
	self.shape.xScale = 2.5
	self.shape.yScale = 2.5
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”
	self.exploding = false
	self.destroy = false

	game.parentView:insert(self.shape)

	self:move(startingId)

	return self
end

function Enemies:hit(damage)
	self.HP = self.HP - damage;
	if (self.HP <= 0) then
		-- die
		timer.cancel( self.timerRef )
		transition.cancel( self.transitionRef )
		
		self:explode()
	end
end

function Enemies:explode()
	local x = self.shape.x
	local y = self.shape.y
	self.exploding = true

	self.shape:removeSelf()
	self.shape = display.newImage( sheet, 4 )
	self.shape.x = x
	self.shape.y = y
	self.game.parentView:insert(self.shape)

	transition.to(self.shape, {
		alpha = 0,
		xScale = 2.5,
		yScale = 2.5,
		onComplete = function() 
			self.destroy = true
		end
	})
end

function Enemies:move()
	local current = self.game.grid[self.nodeId];
	local target = self.game.grid[current.cameFrom] or {};

	local x = grid.x(target.column)
	local y = grid.y(target.row)
	local it = self

	if x > self.shape.x then
		self.shape.rotation = 180
	elseif x < self.shape.x then
		self.shape.rotation = 0
	elseif y > self.shape.y then
		self.shape.rotation = 270
	elseif y < self.shape.y then
		self.shape.rotation = 90
	end


	self.timerRef = timer.performWithDelay( self.speed / 2, function() 
		self.nodeId = current.cameFrom
	end)

	self.transitionRef = transition.to(self.shape, {
		x = x,
		y = y,
		time = self.speed,
		onComplete = function()
			if target.type == 'goal' then

			else
				it:move()
			end
		end
	})
end

return Enemies