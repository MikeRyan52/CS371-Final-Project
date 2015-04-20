local composer = require 'composer'
local widget = require 'widget'
local loadLevel = require 'utilities.load-level'
local grid = require 'utilities.grid'
local Game = require 'objects.game'
local thisGame = Game:new()
local CELL_SIZE = grid.cellSize
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

	local bg = display.newImageRect('space-background2.jpg', 1920, 1080)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)

	local topbar = display.newRect(sceneGroup, display.actualContentWidth / 2, 75, display.actualContentWidth, 150)
	topbar:setFillColor(0.05, 0.09, 0.2)

	local scrollView = widget.newScrollView
	{
		top = 150,
		left = 0,
		width = display.actualContentWidth,
		height = display.actualContentHeight - 150,
		scrollWidth = 30 * CELL_SIZE,
		scrollHeight = 50 * CELL_SIZE,
		listener = scrollListener,
		hideBackground = true
	}

	sceneGroup:insert(scrollView)


	thisGame:init(event.params.level, scrollView, sceneGroup)

	scrollView:setScrollWidth(30*CELL_SIZE)
	scrollView:setScrollHeight(50*CELL_SIZE)

	timer.performWithDelay( 1000, function()
		thisGame:start()
	end)
end

scene:addEventListener( 'create', scene )

return scene