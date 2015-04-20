local composer = require 'composer'
local scene = composer.newScene()

function scene:create(event)
	print('Game over')
	composer.removeScene('views.level', false)
end

scene:addEventListener('create', scene)

return scene