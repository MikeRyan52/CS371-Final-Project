local composer = require 'composer'
local scene = composer.newScene()

function scene:create(event)
	print('Game over')
	local gameover = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 300, 150, 5)
	local gameovertext = display.newText( "GAME OVER", display.contentCenterX, display.contentCenterY, system.NativeFont, 50 )
	gameovertext:setFillColor( 0,0,0 )

	gameovertext:addEventListener('tap', function()
		composer.gotoScene('menu.menu')
	end)
end

scene:addEventListener('create', scene)

return scene