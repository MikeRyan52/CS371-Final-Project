local mod = {
	components = {}
}

function mod:new ( name, o ) --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.name = name

	return o
end

function mod:component( name, dependencies )
	self.components[name] = dependencies
end

function mod:run( dependencies )

end