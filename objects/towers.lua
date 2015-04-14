local Towers = {frame=1, xLocation = display.contentCenterX, yLocation = display.contentCenterY, value = 100};
function Towers:new (o) --constructor
	o = o or {};
	--print(o.r, o.g, o.b)
	setmetatable(o, self);
	self.__index = self;
	return o;
end
local opt = 
{

	frames = { 
		{x = 275, y = 0, width = 75, height =68},	--frame 1
		{x = 275, y = 68, width = 75, height = 68}, --frame 2
		{x= 275, y = 135, width = 80, height = 68}, --frame 3
		{x = 195, y = 0, width = 75, height =68},	--frame 4
		{x = 195, y = 68, width = 75, height = 68}, --frame 5
		{x= 202, y = 135, width = 75, height = 68}, --frame 6
		{x = 120, y = 0, width = 75, height =68},	--frame 7
		{x = 135, y = 68, width = 60, height = 68}, --frame 8
		{x= 135, y = 135, width = 70, height = 68}, --frame 9

}

}
local sheet = graphics.newImageSheet( "towersheetone.png", opt)
function Towers:spawn()
	self.shape = display.newImage( sheet, self.frame)
	self.shape.x = self.xLocation
	self.shape.y = self.yLocation
	self.shape.xScale = 1
	self.shape.yScale = 1
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”
	physics.addBody(self.shape, "static");

end
function Towers:Upgrade()
	if self.frame == 1 then
		self.shape.removeSelf()
		self.frame = 2
		self:spawn()
	elseif self.frame == 2 then
		self.frame = 3
	elseif self.frame == 4 then
		self.frame = 5
	elseif self.frame == 5 then
		self.frame = 6	
	elseif self.frame == 7 then
		self.frame = 8
	elseif self.frame == 8 then
		self.frame = 9
	end
end

function Towers:Sell ()
	self.shape:removeSelf();
	self.shape=nil;
	self = nil;
end
return Towers