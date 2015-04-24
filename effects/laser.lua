function laser(displayGroup, originShape, targetShape)
	local circle = display.newCircle(originShape.x, originShape.y, 10)
	circle:setFillColor(0, 0.7, 0.4)
	displayGroup:insert(circle)
	transition.to(circle, {
		time = 200,
		x = targetShape.x,
		y = targetShape.y,
		onComplete = function()
		if circle ~= nil then 
			circle:removeSelf()
		end
		
		end
	})
end

return laser