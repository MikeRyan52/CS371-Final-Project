local json = require 'json'

function loadLevel(name)
	local level
	local path = system.pathForFile( 'levels/level-' .. name .. '.json', system.ResourceDirectory )
	local file, errorMessage = io.open( path, "r" )

	if file then    -- nil if no file found
		local contents = file:read( "*a" )
	    level = json.decode( contents )
	    file:close( file )
	else
		print(errorMessage)
	end

	return level
end

return loadLevel