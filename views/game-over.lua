local composer = require 'composer'
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	local gameover = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 300, 150, 5)
	local gameovertext = display.newText( "GAME OVER", display.contentCenterX, display.contentCenterY, system.NativeFont, 50 )
	gameovertext:setFillColor( 0,0,0 )
	sceneGroup:insert(gameover)
	sceneGroup:insert(gameovertext)
	gameover:addEventListener('tap', function()
		composer.gotoScene('menu.menu')
	end)
end

scene:addEventListener('create', scene)

return scene