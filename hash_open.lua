local hash_open = {}
hash_open.__index = hash_open

function hash_open:new(size, hash_method, probe_method)
    local obj = {
        size = size or 10,
        table = {},
        hash_method = hash_method or "division", -- Default to division
        probe_method = probe_method or "linear"  -- Default to linear probing
    }

    -- Validate hash_method
    if obj.hash_method ~= "division" and obj.hash_method ~= "multiplication" then
        error("Invalid hash_method. Use 'division' or 'multiplication'.")
    end

    -- Validate probe_method
    if obj.probe_method ~= "linear" and obj.probe_method ~= "quadratic" then
        error("Invalid probe_method. Use 'linear' or 'quadratic'.")
    end

    -- Initialize table with nil (empty slots)
    for i = 1, obj.size do
        obj.table[i] = nil
    end

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function hash_open:hash(key, i)
    local h
    if self.hash_method == "division" then
        h = key % self.size
    elseif self.hash_method == "multiplication" then
        local A = (math.sqrt(5) - 1) / 2
        h = math.floor(self.size * ((key * A) % 1))
    end

    if self.probe_method == "linear" then
        -- Linear probing: (h + i) % size + 1
        return (h + i) % self.size + 1
    elseif self.probe_method == "quadratic" then
        -- Quadratic probing: (h + i^2) % size + 1
        return (h + i * i) % self.size + 1
    end
end

function hash_open:HashInsert(key, value)
    local i = 0
    while i < self.size do
        local index = self:hash(key, i)
        local slot = self.table[index]

        -- If slot is empty (nil) or marked as deleted ("DELETED"), insert here
        if slot == nil or slot == "DELETED" then
            self.table[index] = {key = key, value = value}
            return true
        end
        -- If key already exists, update value
        if type(slot) == "table" and slot.key == key then
            slot.value = value
            return true
        end
        i = i + 1 -- Try next slot
    end
    return false -- Table is full
end

function hash_open:HashSearch(key)
    local i = 0
    while i < self.size do
        local index = self:hash(key, i)
        local slot = self.table[index]
        
        if slot == nil then
            return nil -- Empty slot, key not found
        end
        if type(slot) == "table" and slot.key == key then
            return slot.value -- Key found
        end
        -- Continue searching if slot is "DELETED" or occupied by another key
        i = i + 1
    end
    return nil -- Key not found after full search
end

function hash_open:HashDelete(key)
    local i = 0
    while i < self.size do
        local index = self:hash(key, i)
        local slot = self.table[index]
        
        if slot == nil then
            return false -- Empty slot, key not found
        end
        if type(slot) == "table" and slot.key == key then
            self.table[index] = "DELETED" -- Mark as deleted (tombstone)
            return true
        end
        i = i + 1
    end
    return false -- Key not found
end

function hash_open:HashShow()
    for i = 1, self.size do
        io.write(i - 1 .. ": ")
        local slot = self.table[i]
        if slot == nil then
            io.write("nil")
        elseif slot == "DELETED" then
            io.write("DELETED")
        elseif type(slot) == "table" then
            io.write("(" .. slot.key .. ", " .. slot.value .. ")")
        end
        print()
    end
end

return hash_open
