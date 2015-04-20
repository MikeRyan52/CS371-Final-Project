local grid = require 'utilities.grid'

function bloom(displayGroup, originShape, targetRadius)
	local circle = display.newCircle(originShape.x, originShape.y, 30)
	circle:setFillColor(0.8, 0.2, 0.2, 0.4)
	displayGroup:insert(circle)
	local finalRadius = targetRadius * grid.cellSize;

	transition.to(circle, {
		time = 200,
		xScale = finalRadius / 30,
		yScale = finalRadius / 30,
		onComplete = function()
			circle:removeSelf()
		end
	})
end

return bloom