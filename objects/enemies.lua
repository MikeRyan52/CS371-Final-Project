local Enemies = {frame=1, xSpawn = display.contentCenterX, ySpawn = display.contentCenterY, HP = 1};
function Enemies:new (o) --constructor
 o = o or {};
 --print(o.r, o.g, o.b)
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
function Enemies:spawn()
self.shape= display.newImage( sheet, 4)
self.shape.x = self.xSpawn
self.shape.y = self.ySpawn
self.shape.xScale = 1.6
self.shape.yScale = 1.6
self.shape.y = display.contentCenterY
self.shape.pp = self; -- parent object
self.shape.tag = self.tag; -- “enemy”
physics.addBody(self.shape, "static");
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
return Enemies