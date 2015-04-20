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

function scene:create(event)
	local sceneGroup = self.view

	local scrollView = widget.newScrollView
	{
		top = 150,
		left = 0,
		width = display.actualContentWidth,
		height = display.actualContentHeight - 150,
		scrollWidth = 30 * CELL_SIZE,
		scrollHeight = 50 * CELL_SIZE,
		listener = scrollListener,
		backgroundColor = {0, 0, 0}
	}

	sceneGroup:insert(scrollView)

	-- local bg = display.newImage( "spacebackground.png", display.contentCenterX, display.contentCenterY)
	-- bg.xScale = ( 30 * CELL_SIZE ) / bg.width
	-- bg.yScale = display.contentHeight / bg.height

	-- scrollView:insert(bg)


	thisGame:init('one', scrollView, sceneGroup)
end

scene:addEventListener( 'create', scene )

return scene