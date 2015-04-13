
local composer = require("composer");
local scene = composer.newScene()
-- "scene:create()"
function scene:create(event)

	local sceneGroup = self.view
		
	-- Initialize the scene here.
	-- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		local bg = display.newImage( sceneGroup,"space-background3.png", display.contentCenterX, display.contentCenterY)
		bg.xScale = display.contentWidth/ bg.width
		bg.yScale = display.contentHeight/ bg.height
		local mainbutton = display.newRoundedRect(sceneGroup, display.contentWidth/2, 100, 530, 150 , 25)
		mainbutton.alpha = .3
		local maintext = display.newText( sceneGroup, "Main Menu", display.contentWidth/2, 100, system.NativeFont, 100 )
		maintext:setFillColor( 0,0,0 )
		local creditdeclaration = display.newText( sceneGroup, "Credits go to the following sources", display.contentWidth/2, 225,system.NativeFont, 46 )
		local firstcredit = display.newText( sceneGroup, "http://www.deviantart.com/morelikethis/99012258", display.contentCenterX, 275,  system.NativeFont, 30 )
		local secondcredit = display.newText( sceneGroup, "http://www.deviantart.com/morelikethis/43030167", display.contentCenterX, 325,  system.NativeFont, 30 )
		local thirdcredit = display.newText( sceneGroup,
			"http://freegameassets.blogspot.com/2015/02/free-tower-defence-sets-this-free-tower.html", display.contentCenterX, 370, system.NativeFont, 17 )
		thirdcredit:setFillColor(0,0,0)
		local function GoToMainMenu()
			composer.gotoScene( "menu.menu" )
		end
		mainbutton:addEventListener( "tap", GoToMainMenu )
		-- Called when the scene is still off screen (but is about to come on screen).
	elseif ( phase == "did" ) then

	
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start timers, begin animation, play audio, etc.
	end
end

-- "scene:hide()"
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

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



end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene
