local composer = require 'composer'
local widget = require 'widget'
local loadLevel = require 'utilities.load-level'

local CELL_SIZE = 50

function x( column )
	return ( column * CELL_SIZE ) + ( CELL_SIZE / 2 )
end

function y( row )
	return ( row * CELL_SIZE ) + ( CELL_SIZE / 2 )
end

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


for index, space in ipairs(level.grid)  do
	local rect = display.newRect(
		x(space.column),
		y(space.row),
		CELL_SIZE,
		CELL_SIZE
	)

	if space.type == 'path' then
		rect:setFillColor( 0, 0, 200, 0.5 )
	elseif space.type == 'spawn' then
		rect:setFillColor( 200, 0, 0, 0.5 )
	elseif space.type == 'goal' then
		rect:setFillColor( 0, 200, 0, 0.5 )
	end

	scrollView:insert(rect)
end



return scene