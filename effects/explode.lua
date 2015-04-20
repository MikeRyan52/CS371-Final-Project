function explode(displayGroup, targetShape, radius)
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

	local explosion = display.newImage(sheet, 4)
	displayGroup:insert(explosion)
	explosion.x = targetShape.x
	explosion.y = targetShape.y

	transition.to(explosion, {
		time = 200,
		xScale = radius,
		yScale = radius,
		alpha = 0,
		onComplete = function()
			explosion:removeSelf()
		end
	})
end

return explode