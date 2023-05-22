-- env.lua
-- darky

local env = getfenv(2)
local utilities = {}

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

for index: string, callback: (...any)->...any in pairs(utilities) do
	env[index] = callback
end

return true, env
