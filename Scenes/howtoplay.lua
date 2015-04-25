
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
		local firsttext = display.newText( sceneGroup, "Your goal is to prevent the enemies from reaching at the end of their path", 350, 250, system.NativeFont, 20)
		local secondtext = display.newText( sceneGroup, "There will be three waves per level where enemies will come at your city", 350, 300, system.NativeFont, 20)
		local thirdtext = display.newText( sceneGroup, "You must create and upgrade towers in order defend your city from the invading ships", 350, 350, system.NativeFont, 17)
		local fourthtext = display.newText( sceneGroup, "You can place towers by tapping on the asteroids and then choose the tower you desire", 350, 400,  system.NativeFont, 17)
		--local fourthtext = display.newText( sceneGroup, "", x, y, [width, height,], font, fontSize )
		local opt = 
		{

			frames = { 
				{x = 100, y = 65, width = 25, height =30},--frame 1, value 75 
				{x = 60, y = 35, width = 35, height = 30}, --frame 2, HP 80, speed 400, 50 
				{x= 94, y = 35, width = 35, height = 30}, --frame 3, HP 800, speed 50, 150
				{x = 190, y = 224, width = 35, height = 30}, --frame 4
				{x = 225, y = 219, width = 35, height = 30}, --frame 5
			}
		}

		local sheet = graphics.newImageSheet( "spaceships2.png", opt)
		local displayenemy1 = display.newImage(sceneGroup, sheet, 1 )
		displayenemy1.x = 100
		displayenemy1.y = 500
		displayenemy1.xScale = 2.3
		displayenemy1.yScale = 2.3
		local enemyonedesc = display.newText( sceneGroup, "Striker class ship", 375, 450, system.NativeFont, 25)
		local enemyonedescpt2 = display.newText( sceneGroup, "Health:240", 375, 475, system.NativeFont, 25)
		local enemyonedescpt3 = display.newText( sceneGroup, "Speed:400", 375, 500, system.NativeFont, 25)
		local enemyonedescpt4 = display.newText( sceneGroup, "Damage:1", 375, 525, system.NativeFont, 25)
		local enemyonedescpt5 = display.newText( sceneGroup, "Value: 60", 375, 550, system.NativeFont, 25)
		
		local displayenemy2 = display.newImage(sceneGroup, sheet, 2 )
		displayenemy2.x = 100
		displayenemy2.y = 700
		displayenemy2.xScale = 2.3
		displayenemy2.yScale = 2.3
		local enemytwodesc = display.newText( sceneGroup, "Speeder class ship", 375, 650, system.NativeFont, 25)
		local enemytwodescpt2 = display.newText( sceneGroup, "Health:80", 375, 675, system.NativeFont, 25)
		local enemytwodescpt3 = display.newText( sceneGroup, "Speed:400", 375, 700, system.NativeFont, 25)
		local enemytwodescpt4 = display.newText( sceneGroup, "Damage:2", 375, 725, system.NativeFont, 25)
		local enemytwodescpt5 = display.newText( sceneGroup, "Value: 50", 375, 750, system.NativeFont, 25)

		local displayenemy3 = display.newImage(sceneGroup, sheet, 3 )
		displayenemy3.x = 100
		displayenemy3.y = 900
		displayenemy3.xScale = 2.3
		displayenemy3.yScale = 2.3
		local enemythreedesc = display.newText( sceneGroup, "Fortress class ship", 375, 850, system.NativeFont, 25)
		local enemythreedescpt2 = display.newText( sceneGroup, "Health:800", 375, 875, system.NativeFont, 25)
		local enemythreedescpt3 = display.newText( sceneGroup, "Speed:50", 375, 900, system.NativeFont, 25)
		local enemythreedescpt4 = display.newText( sceneGroup, "Damage:4", 375, 925, system.NativeFont, 25)
		local enemythreedescpt5 = display.newText( sceneGroup, "Value: 150", 375, 950, system.NativeFont, 25)

		local displaytowers =  display.newRoundedRect( sceneGroup, display.contentWidth/2 + 200, 1100, 250, 150 , 25 )
		displaytowers.alpha = .3
		local towerstext = display.newText( sceneGroup, "Towers", display.contentWidth/2 + 200, 1100, system.NativeFont, 45 )
		towerstext:setFillColor( 0,0,0 )

		local function Displaytowerinfo()
			composer.gotoScene( "Scenes.howtoplaytowers")



		end
		displaytowers:addEventListener( "tap", Displaytowerinfo )
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
