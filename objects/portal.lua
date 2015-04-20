local json = require 'json'
local TowerTypes = require 'utilities.tower-types'
local laser = require 'effects.laser'
local bloom = require 'effects.bloom'
local explode = require 'effects.explode'

local Portal = {
	frame = 1, 
	xLocation = display.contentCenterX, 
	yLocation = display.contentCenterY, 
};

function Portal:new (o) --constructor
	o = o or {};

	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Portal:spawn(game, type, id, node)
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
local opt = {

	frames = {
	{x = 0, y = 0, width = 60, height = 60}
	}
}

function Portal:draw()
	local sheet = graphics.newImageSheet( "portalspawnpoint2.png", opt)
	self.shape = display.newImage( sheet, self.frame)
	self.shape.x = self.xLocation
	self.shape.y = self.yLocation
	self.shape.xScale = 1.5
	self.shape.yScale = 1.5
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “enemy”

	self.parentView:insert(self.shape)
	self.shape:addEventListener("tap", self)
end


return Portal