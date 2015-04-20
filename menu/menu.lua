
local composer = require("composer");
local scene = composer.newScene()
-- "scene:create()"
function scene:create(event)

	local sceneGroup = self.view
	composer.removeHidden()
		
	-- Initialize the scene here.
	-- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
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
		-- Called when the scene is still off screen (but is about to come on screen).
	elseif ( phase == "did" ) then
		local startbutton = display.newRoundedRect(sceneGroup, display.contentWidth/2, display.contentHeight/2 - 200, 530, 150 , 25)
		startbutton.alpha = .8
		startbutton:setFillColor(0.2, 0.6, 0.86)
		local starttext = display.newText( sceneGroup, "New Game", display.contentWidth/2, display.contentHeight/2 - 200, system.NativeFont, 42 )
		starttext:setFillColor( 1, 1, 1 )
		local howtoplaybutton = display.newRoundedRect(sceneGroup, display.contentWidth/2, display.contentHeight/2, 530, 150 , 25)
		howtoplaybutton.alpha = .4
		howtoplaybutton:setFillColor(0.16, 0.5, 0.73)
		local howtoplaytext = display.newText( sceneGroup, "How to Play", display.contentWidth/2, display.contentHeight/2, system.NativeFont, 42 )
		howtoplaytext:setFillColor( 1, 1, 1 )
		local creditsbutton = display.newRoundedRect(sceneGroup, display.contentWidth/2, display.contentHeight/2 + 200, 530, 150 , 25)
		creditsbutton.alpha = .4
		creditsbutton:setFillColor(0.16, 0.5, 0.73)
		local creditstext = display.newText( sceneGroup, "Credits", display.contentWidth/2, display.contentHeight/2 + 200, system.NativeFont, 42 )
		creditstext:setFillColor( 1, 1, 1 )
		local function HowToPlay()
			composer.gotoScene( "Scenes.howtoplay" )
		end
		local function startlevelone ()
		
			composer.gotoScene( 'views.level', {
				params = {
					level = 1
				}
			})
		end
		local function Credits()
			composer.gotoScene( "Scenes.credits" )
		end
		startbutton:addEventListener("tap", startlevelone)
		howtoplaybutton:addEventListener( "tap", HowToPlay )
		creditsbutton:addEventListener( "tap", Credits )
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start timers, begin animation, play audio, etc.
	end
end

-- "scene:hide()"
function scene:hide( event )

	if ( phase == "will" ) then
		-- Called when the scene is on screen (but is about to go off screen).
		-- Insert code here to "pause" the scene.
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
		-- Called immediately after scene goes off screen.
	end
end
-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view
	local phase = event.phase
	sceneGroup:removeSelf( )


end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene
