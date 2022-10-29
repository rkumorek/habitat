-- Splits a string by given separator.
-- @param str - string
-- @param separator - string
-- @return first table of strings
local function split(str, separator)
    if not (type(str) == 'string' and type(separator) == 'string') then
        return { str }, 1
    end

    local result = {}
    local index = 0

    for slice in string.gmatch(str, '([^' .. separator .. ']+)') do
        index = index + 1
        result[index] = slice
    end

    return result
end

-- Returns a table without trailing elements.
-- @param list - table
-- @param len - length of a table
-- @param skip_count - number of elements to skip
-- @return table
local function skip_last_n(list, skip_count)
    local len = #list
    local index = 0
    local result = {}

    if skip_count == nil then skip_count = 1 end

    while index + skip_count < len do
        index = index + 1
        result[index] = list[index]
    end

    return result
end

-- Returns a head of a table.
-- @param list - table
-- @param len - length of a table
-- @param take_count - number of elements to select
-- @return table
-- @return table length
local function take_first_n(list, len, take_count)
    local result = {}
    local index = 0

    if take_count == nil then take_count = 1 end

    while index < len and index < take_count do
        index = index + 1;
        result[index] = list[index]
    end

    return result, index
end

return { split = split, skip_last_n = skip_last_n, take_first_n = take_first_n }
