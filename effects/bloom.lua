local grid = require 'utilities.grid'

function bloom(displayGroup, originShape, targetRadius)
	local circle = display.newCircle(originShape.x, originShape.y, 10)
	circle:setFillColor(0.8, 0.2, 0.2, 0.4)
	displayGroup:insert(circle)
	local finalRadius = targetRadius * grid.cellSize;

	transition.to(circle, {
		time = 200,
		xScale = finalRadius / 10,
		yScale = finalRadius / 10,
		onComplete = function()
			circle:removeSelf()
		end
	})
end

return bloom