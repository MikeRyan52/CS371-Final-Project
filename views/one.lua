local composer = require 'composer'
local widget = require 'widget'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local Enemies = require 'objects.enemies'
local physics = require 'physics'
local Game = require 'objects.game'
local thisGame = Game:new()
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
bg.xScale = ( 30 * CELL_SIZE ) / bg.width
bg.yScale = display.contentHeight / bg.height

scrollView:insert(bg)


thisGame:init('one', scrollView)


return scene