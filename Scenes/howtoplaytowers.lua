
local enemies = require("objects.enemies")
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
		local bg = display.newImage( sceneGroup,"spacebackground.png", display.contentCenterX, display.contentCenterY)
		bg.xScale = display.contentWidth/ bg.width
		bg.yScale = display.contentHeight/ bg.height
		local mainbutton = display.newRoundedRect(sceneGroup, display.contentWidth/2, 100, 530, 150 , 25)
		mainbutton.alpha = .3
		local maintext = display.newText( sceneGroup, "Main Menu", display.contentWidth/2, 100, system.NativeFont, 100 )
		maintext:setFillColor( 0,0,0 )
		local firsttext = display.newText( sceneGroup, "You will click on the space to pull up the menu for tower palcement", 350, 250, system.NativeFont, 23)
		firsttext:setFillColor( 1,1,0 )
		local secondext = display.newText( sceneGroup, "Upgrading the towers will improve either damage, radius, or fire speed", 350, 275, system.NativeFont, 22 )
		secondext:setFillColor( 1,1,0 )
		local thirdtext = display.newText( sceneGroup, "The laser towers hit one unit at a time", 350, 300, system.NativeFont, 25 )
		thirdtext:setFillColor( 1,1,0 )
		local fourthtext = display.newText( sceneGroup, "The cannon towers hit a small chunk of units", 350, 325, system.NativeFont, 25 )
		fourthtext:setFillColor( 1,1,0 )
		local fifthtext = display.newText( sceneGroup, "The generator will hit all enemies within its radius", 350, 350, system.NativeFont, 25 )
		fifthtext:setFillColor( 1,1,0 )
		--local fourthtext = display.newText( sceneGroup, "", x, y, [width, height,], font, fontSize )
		local opt = 
		{

			frames = { 
				{x = 275, y = 0, width = 75, height =68},	--frame 1
				{x = 275, y = 68, width = 75, height = 68}, --frame 2, cost = 300, value = 200, radius = 5, fireSpeed = 300, damage = 40
				{x= 275, y = 135, width = 80, height = 68}, --frame 3, cost = 300, value = 300, radius = 6, fireSpeed = 350, damage = 80
				
				{x = 195, y = 0, width = 75, height =68},	--frame 4, cost = 200, value = 50, radius = 3, fireSpeed = 350, damage = 5
				{x = 195, y = 68, width = 75, height = 68}, --frame 5, cost = 200, value = 100, radius = 4, fireSpeed = 400, damage = 20
				{x= 202, y = 135, width = 75, height = 68}, --frame 6, cost = 400, value = 400, radius = 5, fireSpeed = 600, damage = 20
				
				{x = 120, y = 0, width = 75, height =68},	--frame 7
				{x = 135, y = 68, width = 60, height = 68}, --frame 8
				{x= 135, y = 135, width = 70, height = 68}, --frame 9
			}
		}
		local opt2 = 
		{

			frames = {
				{x = 0, y=0, width = 69, height = 68}, --frame 1 of aoe Tower, cost = 400, value = 200, radius = 3, firespeed = 150, damage = 5
				{x = 62, y = 0, width = 69, height = 68}, --frame 2 of aoe, cost = 350, value = 300, radius = 4, fireSpeed = 150, damage = 20
				{x = 125, y = 0, width = 69, height = 68},	--frame 3 of aoe, cost = 400, value = 500, radius = 4, fireSpeed = 350, damage = 20
			}
		}
		local sheet = graphics.newImageSheet( "towersheetone.png", opt)
		local sheet2 = graphics.newImageSheet( "towersheettwo.png", opt2 )
		local displayenemy1 = display.newImage(sceneGroup, sheet, 1 )
		displayenemy1.x = 118
		displayenemy1.y = 500
		displayenemy1.xScale = 1.5
		displayenemy1.yScale = 1.5
		local enemyonedesc = display.newText( sceneGroup, "Laser Tower", 375, 450, system.NativeFont, 25)
		local enemyonedescpt2 = display.newText( sceneGroup, "Damage: 40", 375, 475, system.NativeFont, 25)
		local enemyonedescpt3 = display.newText( sceneGroup, "Radius: 4", 375, 500, system.NativeFont, 25)
		local enemyonedescpt4 = display.newText( sceneGroup, "Firespeed:100", 375, 525, system.NativeFont, 25)
		local enemyonedescpt5 = display.newText( sceneGroup, "Value: 100", 375, 550, system.NativeFont, 25)
		local enemyonedescpt6 = display.newText( sceneGroup, "Cost: 300", 375, 575, system.NativeFont, 25)
		
		local displayenemy2 = display.newImage(sceneGroup, sheet, 4 )
		displayenemy2.x = 100
		displayenemy2.y = 700
		displayenemy2.xScale = 1.5
		displayenemy2.yScale = 1.5
		local enemytwodesc = display.newText( sceneGroup, "Cannon Tower", 375, 650, system.NativeFont, 25)
		local enemytwodescpt2 = display.newText( sceneGroup, "Damage:20", 375, 675, system.NativeFont, 25)
		local enemytwodescpt3 = display.newText( sceneGroup, "Radius:3", 375, 700, system.NativeFont, 25)
		local enemytwodescpt4 = display.newText( sceneGroup, "Firespeed:350", 375, 725, system.NativeFont, 25)
		local enemytwodescpt5 = display.newText( sceneGroup, "Value: 50", 375, 750, system.NativeFont, 25)
		local enemytwodescpt6 = display.newText( sceneGroup, "Cost: 200", 375, 775, system.NativeFont, 25)

		local displayenemy3 = display.newImage(sceneGroup, sheet2, 1 )
		displayenemy3.x = 115
		displayenemy3.y = 900
		displayenemy3.xScale = 1.5
		displayenemy3.yScale = 1.5
		local enemythreedesc = display.newText( sceneGroup, "Electromagnetic Field Generator", 375, 850, system.NativeFont, 25)
		local enemythreedescpt2 = display.newText( sceneGroup, "Damage:5", 375, 875, system.NativeFont, 25)
		local enemythreedescpt3 = display.newText( sceneGroup, "Radius:3", 375, 900, system.NativeFont, 25)
		local enemythreedescpt4 = display.newText( sceneGroup, "Firespeed:150", 375, 925, system.NativeFont, 25)
		local enemythreedescpt5 = display.newText( sceneGroup, "Value: 300", 375, 950, system.NativeFont, 25)
		local enemythreedescpt6 = display.newText( sceneGroup, "Cost: 400", 375, 975, system.NativeFont, 25)

		local displayenemies =  display.newRoundedRect( sceneGroup, display.contentWidth/2 + 200, 1100, 250, 150 , 25 )
		displayenemies.alpha = .3
		local enemiestext = display.newText( sceneGroup, "Enemies", display.contentWidth/2 + 200, 1100, system.NativeFont, 45 )
		enemiestext:setFillColor( 0,0,0 )

		local function Displaytowerinfo()
			composer.gotoScene( "Scenes.howtoplay")



		end
		displayenemies:addEventListener( "tap", Displaytowerinfo )
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
