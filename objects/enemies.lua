local grid = require 'utilities.grid'

local Enemies = {
	frame=1, 
	xSpawn = display.contentCenterX, 
	ySpawn = display.contentCenterY, 
	HP = 1,
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
		{x = 100, y = 65, width = 25, height =30},--frame 1
		{x = 60, y = 35, width = 35, height = 30}, --frame 2
		{x= 94, y = 35, width = 35, height = 30}, --frame 3
		{x = 190, y = 224, width = 35, height = 30}, --frame 4
		{x = 225, y = 219, width = 35, height = 30}, --frame 5
	}
}

local sheet = graphics.newImageSheet( "spaceships2.png", opt)
function Enemies:spawn(game, startingId)
	self.game = game
	self.startingId = startingId
	self.shape= display.newImage( sheet, self.frame)
	self.shape.x = self.xSpawn
	self.shape.y = self.ySpawn
	self.shape.xScale = 2.5
	self.shape.yScale = 2.5
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”

	game.parentView:insert(self.shape)

	self:move(startingId)

	return self
end

function Enemies:hit ()
	self.HP = self.HP - 1;
	if (self.HP == 0) then
		-- die
		self.shape:removeSelf();
		self.shape=nil;
		self = nil;
	end
end

function Enemies:move(startingId)
	local current = self.game.grid[startingId];
	local target = self.game.grid[current.cameFrom] or {};
	if not self.pathId then self.pathId = current.id end

	local x = grid.x(target.column)
	local y = grid.y(target.row)
	local it = self

	timer.performWithDelay( self.speed / 2, function() 
		it.pathId = target.id
	end)

	transition.to(self.shape, {
		x = x,
		y = y,
		time = self.speed,
		onComplete = function()
			if target.type == 'goal' then

			else
				it:move(current.cameFrom)
			end
		end
	})
end

return Enemies