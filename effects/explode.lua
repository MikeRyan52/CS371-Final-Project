function explode(displayGroup, sourceShape, targetShape, radius)
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

	local circle = display.newCircle(sourceShape.x, sourceShape.y, 14)
	displayGroup:insert(circle)
	circle:setFillColor(0, 0, 0)

	transition.to(circle, {
		time = 200,
		x = targetShape.x,
		y = targetShape.y,
		onComplete = function()
			circle:removeSelf()
			
			local explosion = display.newImage(sheet, 4)
			displayGroup:insert(explosion)
			explosion.x = targetShape.x
			explosion.y = targetShape.y

			transition.to(explosion, {
				time = 200,
				xScale = radius * 1.2,
				yScale = radius * 1.2,
				alpha = 0,
				onComplete = function()
				if explosion ~= nil then 
					explosion:removeSelf()
				end 
				end
			})
		end
	})
end

return explode