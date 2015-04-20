local cellSize = 30

function x( column )
	return ( column * cellSize ) + ( cellSize / 2 )
end

function y( row )
	return ( row * cellSize ) + ( cellSize / 2 )
end

return {
	cellSize = cellSize,
	x = x,
	y = y
}