local Game = {
	health = 20,
	money = 250,
	updateHealth = true,
	updateMoney = true
}

function Game:new(o)
	o = o or {}
	setmetatable(o, self);
	self.__index = self;

	return o;
end

function Game:start(displayGroup)
	self.group = displayGroup
	Runtime:addEventListener( 'enterFrame', self )
	print('starting')
end

function Game:stop()
	Runtime:removeEventListener( 'enterFrame', self )
end

function Game:purchaseItem(event)
	self.money = self.money - event.cost
	self.updateMoney = true
end

function Game:enemyReachedGoal(event)
	self.health = self.health - event.damage
	self.updateHealth = false
end

function Game:enterFrame()
	if self.updateHealth then

	end
end

return Game