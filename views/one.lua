local composer = require 'composer'
local widget = require 'widget'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local Enemies = require 'objects.enemies'
local physics = require 'physics'
local Game = require 'objects.game'

local thisGame = Game:new()
thisGame:start()
local Asteroid = require("objects.asteroid")

physics.start()

local CELL_SIZE = grid.cellSize



local scene = composer.newScene()
local level = loadLevel('one')
local scrollView = widget.newScrollView
{
	top = 150,
	left = 0,
	width = display.actualContentWidth,
	height = display.actualContentHeight - 300,
	scrollWidth = 30 * CELL_SIZE,
	scrollHeight = 50 * CELL_SIZE,
	listener = scrollListener
}

local bg = display.newImage( "spacebackground.png", display.contentCenterX, display.contentCenterY)
bg.xScale = display.contentWidth / bg.width
bg.yScale = display.contentHeight / bg.height

scrollView:insert(bg)

local meteor = Asteroid:new()
Asteroid:spawn()
local spawnId


for id, space in pairs(level.grid)  do
	local rect = display.newRect(
		grid.x(space.column),
		grid.y(space.row),
		CELL_SIZE,
		CELL_SIZE
	)

	if space.type == 'path' then
		rect:setFillColor( 0, 0, 200, 0.5 )
	elseif space.type == 'spawn' then
		rect:setFillColor( 200, 0, 0, 0.5 )
		spawnId = id
	elseif space.type == 'goal' then
		rect:setFillColor( 0, 200, 0, 0.5 )
	elseif space.type == 'tower' then
		rect:setFillColor( 0, 200, 0, .5 )
	end

	scrollView:insert(rect)
end

local enemy = Enemies:new()
enemy.xSpawn = 0
enemy.ySpawn = 0															
enemy:spawn()
scrollView:insert(enemy.shape)
enemy:move(spawnId, level.grid)

return scene