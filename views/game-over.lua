local composer = require 'composer'
local scene = composer.newScene()

function scene:create(event)
--<<<<<<< HEAD
	print('Game over')
			local bg = display.newImage( sceneGroup,"Space_City_2_by_TLBKlaus.png", display.contentCenterX, display.contentCenterY)
		local xScale = display.contentWidth/ bg.width
		local yScale = display.contentHeight/ bg.height

		if xScale > yScale then
			bg.xScale = xScale
			bg.yScale = xScale
		else
			bg.xScale = yScale
			bg.yScale = yScale
		end
		local bgOverlay = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
		bgOverlay:setFillColor(0.17, 0.24, 0.31, 0.7)
		local gameover = display.newRoundedRect(sceneGroup, display.contentWidth/2, display.contentHeight/2 - 200, 530, 150 , 25)
		gameover.alpha = .8
		gameover:setFillColor(0.2, 0.6, 0.86)
		local starttext = display.newText( sceneGroup, "GAME OVER", display.contentWidth/2, display.contentHeight/2 - 200, system.NativeFont, 42 )
		starttext:setFillColor( 1, 1, 1 )

	gameovertext:addEventListener('tap', function())
--=======
	local sceneGroup = self.view
	local gameover = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 300, 150, 5)
	local gameovertext = display.newText( "GAME OVER", display.contentCenterX, display.contentCenterY, system.NativeFont, 50 )
	gameovertext:setFillColor( 0,0,0 )
	sceneGroup:insert(gameover)
	sceneGroup:insert(gameovertext)
	gameover:addEventListener('tap', function()
-->>>>>>> origin/master
		composer.gotoScene('menu.menu')
	end)
end

scene:addEventListener('create', scene)

return scene