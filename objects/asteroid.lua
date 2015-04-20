local towers = require("objects.towers")
local Asteroid = {
	frame=1, 
	xLocation = display.contentCenterX, 
	yLocation = display.contentCenterY, 
	value = 100
};
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


function Asteroid:spawn(id, node, game)
	local sheet = graphics.newImageSheet( "meteor2.png", opt)
	self.id = id
	self.node = node
	self.game = game
	self.menuOpen = false

	self.shape = display.newImage( sheet, 1)
	self.game.parentView:insert(self.shape)
	self.shape.x = self.xLocation
	self.shape.y = self.yLocation
	self.shape.xScale = 0.7
	self.shape.yScale = 0.7
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”


	self.shape:addEventListener( "tap", self )

end

function Asteroid:tap(event)

	if not self.menuOpen then
		local towermenu = display.newImage( "buildmenu.png" , self.shape.x +12, self.shape.y -10)
		self.game.parentView:insert(towermenu)
		towermenu.xScale = .6
		towermenu.yScale = .6
		self.menuOpen = true
		local function zoneHandler(event)
		 -- convert the tap position to 3x3 grid position
		 -- based on the board size
			local x, y = event.target:contentToLocal(event.x, event.y);
			x = x + 225; -- conversion
			y = y + 225; -- conversion
			x = math.ceil( x/150 );
			y = math.ceil( y/150 );
			if ((x == 2 and y == 1) or (x == 3 and y == 1)) then 
				towermenu:removeSelf( )
				local newTower = towers:new()
				newTower.xLocation = self.shape.x + 15
				newTower.yLocation = self.shape.y
				newTower.frame = 10
				newTower:spawn(self.game, 'aoe', self.id, self.node)
				isout = false
			elseif  ((x == 0 and y == 3) or (x == 1 and y == 2) or (x == 2 and y == 2) or (x == 2 and y == 3) or (x == 1 and y == 3)) then
				towermenu:removeSelf( )
				local newTower = towers:new()
				newTower.xLocation = self.shape.x + 15
				newTower.yLocation = self.shape.y
				newTower.frame = 4
				newTower:spawn(self.game, 'cannon', self.id, self.node)
				isout = false
				self.shape:removeSelf( )
			elseif ((x == 3 and y == 3) or (x == 3 and y == 2) or (x == 4 and y == 3) or (x == 4 and y == 2)) then
				towermenu:removeSelf( )
				isout = false
				local newTower = towers:new()
				newTower.xLocation = self.shape.x + 15
				newTower.yLocation = self.shape.y
				newTower:spawn(self.game, 'laser', self.id, self.node)
				self.shape:removeSelf()
			end
		end

		towermenu:addEventListener( 'tap', zoneHandler )
	end
end

return Asteroid