local Asteroid = {frame=1, xLocation = display.contentCenterX, yLocation = display.contentCenterY, value = 100};
function Asteroid:new (o) --constructor
	o = o or {};
	--print(o.r, o.g, o.b)
	setmetatable(o, self);
	self.__index = self;
	return o;
end
local opt = 
{

	frames = { 
	{x= 22, y = 35, width = 125, height = 100}
		

}

}
local sheet = graphics.newImageSheet( "meteor2.png", opt)
function Asteroid:spawn()
	self.shape = display.newImage( sheet, 1)
	self.shape.x = display.contentCenterX
	self.shape.y = display.contentCenterY
	self.shape.xScale = .4
	self.shape.yScale = .4
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”
	physics.addBody(self.shape, "static");

end


return Asteroid