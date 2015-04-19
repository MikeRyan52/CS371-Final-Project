local Towers = {frame=1, xLocation = display.contentCenterX, yLocation = display.contentCenterY, value = 100, towertype = "damage"};
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
local opt2 = 
{

	frames2 = {
	{x = 0, y=0, width = 100, height = 68}, --frame 1 of aoe towers
	{x = 75, y = 0, width = 100, height = 68}, --frame 2 of aoe
	{x = 150, y = 0, width = 100, height = 68},	--frame 3 of aoe



	}
}
local isout = false
local sheet = graphics.newImageSheet( "towersheetone.png", opt)
local sheet2 = graphics.newImageSheet( "towersheettwo.png", opt2 )
function Towers:spawn()
	if self.towertype == "aoe" then
	print(self.towertype, self.frame)
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
	physics.addBody(self.shape, "static");

	local function towermenu()
		if isout == false then
		local thistowermenu = display.newImage( "towermenu.png" , self.shape.x, self.shape.y + 40)
		thistowermenu.xScale = .6
		thistowermenu.yScale = .6
		isout = true
			local function zoneHandler(event)
			 -- convert the tap position to 3x3 grid position
			 -- based on the board size
				local x, y = event.target:contentToLocal(event.x, event.y);
				x = x + 225; -- conversion
				y = y + 225; -- conversion
				x = math.ceil( x/150 );
				y = math.ceil( y/150 );
				if ((x == 2 and y == 1) or (x == 3 and y == 1)) then 
					thistowermenu:removeSelf( )
					self:Upgrade()
					isout = false
				elseif  ((x == 0 and y == 3) or (x == 1 and y == 2) or (x == 2 and y == 2) or (x == 2 and y == 3) or (x == 1 and y == 3)) then
					thistowermenu:removeSelf( )
					self.shape:removeSelf()
					isout = false
				elseif ((x == 3 and y == 3) or (x == 3 and y == 2) or (x == 4 and y == 3) or (x == 4 and y == 2)) then
					thistowermenu:removeSelf( )
					isout = false
				end
			end
				thistowermenu:addEventListener("tap", zoneHandler);
		end
	end

	self.shape:addEventListener("tap", towermenu)

end
function Towers:Upgrade()
	if self.frame == 1 then
		self.shape:removeSelf()
		self.frame = 2
		self:spawn()
	elseif self.frame == 2 then
		self.shape:removeSelf()
		self.frame = 3
		self:spawn()
	elseif self.frame == 4 then
		self.shape:removeSelf()
		self.frame = 5
		self:spawn()
	elseif self.frame == 5 then
		self.shape:removeSelf()
		self.frame = 6
		self:spawn()
	elseif self.frame == 7 then
		self.shape:removeSelf()
		self.frame = 8
		self:spawn()
	elseif self.frame == 8 then
		self.shape:removeSelf()
		self.frame = 9
		self:spawn()
	end
end

function Towers:Sell ()
	self.shape:removeSelf();
	self.shape=nil;
	self = nil;
end
return Towers