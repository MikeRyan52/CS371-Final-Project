local composer = require 'composer'
local scene = composer.newScene()

function scene:create(event)
	print('Game over')
	local gameover = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 300, 150, 5)
	local gameovertext = display.newText( "GAME OVER", display.contentCenterX, display.contentCenterY, system.NativeFont, 50 )
	gameovertext:setFillColor( 0,0,0 )
	composer.removeScene('views.level', false)
end

scene:addEventListener('create', scene)

return scene