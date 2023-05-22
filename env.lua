-- env.lua
-- darky

local env = getfenv(2)
local utilities = {}

local loggers = {}
loggers.__index = loggers

--------// Functions

function utilities.toStringTable(table: {any: any}, indexToo)
	local result = {}
	
	for index, value in pairs(table) do
		result[indexToo and tostring(index) or index] = tostring(value)
	end
	
	return result
end

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

function utilities.messageLogger(logger)
	env.print = function(...)
		return logger:add(...)
	end
	env.warn = function(...)
		return logger:add(...)
	end
end

---// Loggers

function utilities.newLogger()
	local logger = setmetatable({}, loggers)
	loggers.logs = {}
	
	return logger
end

function loggers:add(...)
	assert(self, `logger:add must be called with : instead of .`)
	
	table.insert(self.logs, table.concat(utilities.toStringTable(...), " "))
	return true
end

function loggers:get()
	assert(self, `logger:get must be called with : instead of .`)
	
	return self.logs
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
