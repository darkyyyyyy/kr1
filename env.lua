-- env.lua
-- darky

local env = getfenv(2)
local utilities = {}

--------// Functions

function utilities.new(class: string)
	assert(class, `Class required.`)

	local instance = Instance.new(class)
	return function(properties: {string: any})
		assert(properties, `Properties required.`)
		for property, value in pairs(properties) do
			instance[property] = value
		end
		return instance
	end
end

--------// Tables

utilities.services = setmetatable({}, {
	__call = function(self, name)
		return game:GetService(name)
	end,
})

--------// Any



--------// Setup

for index: string, any in pairs(utilities) do
	env[index] = any
end

return true, env
