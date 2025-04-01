local chained_hash_table = {}
chained_hash_table.__index = chained_hash_table

function chained_hash_table:new(size, hash_method)
	local obj = {
		size = size or 10,
		table = {},
		hash_method = hash_method or "division"
	}

	for i = 1, obj.size do
		obj.table[i] = {}
	end

	setmetatable(obj, self)
	self.__index = self
	return obj
end

function chained_hash_table:hash(key)
	if self.hash_method == "division" then
   	return key % self.size + 1
   elseif self.hash_method == "multiplication" then
      local A = (math.sqrt(5) - 1) / 2 -- ≈ 0.6180339887
      return math.floor(self.size * ((key * A) % 1)) + 1
   end
end

function chained_hash_table:insert(key, value)
	local index = self:hash(key)
	table.insert(self.table[index], {key = key, value = value})
end

function chained_hash_table:search(key)
	local index = self:hash(key)
	for _, pair in ipairs(self.table[index])do
		if pair.key == key then
			return pair.value
		end
	end
	return nil
end

function chained_hash_table:delete(key)
	local index = self:hash(key)
	for i, pair in ipairs(self.table[index]) do
		if pair.key == key then
			table.remove(self.table[index], i)
			return true
		end
	end
	return false
end

function chained_hash_table:show()
	for i = 1, self.size do
		io.write(i - 1 .. ": ")
		for _, pair in ipairs(self.table[i]) do
			io.write("(" .. pair.key .. ", " .. pair.value .. ") -> ")
		end
		print("nil")
	end
end

return chained_hash_table
