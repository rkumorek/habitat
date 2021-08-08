-- Splits a string by given separator.
-- @param str - string
-- @param separator - string
-- @return first table of strings
-- @return second number of table elements
local function split(str, separator)
    if not (type(str) == 'string' and type(separator) == 'string') then
        return {str}, 1
    end

    local result = {}
    local index = 0

    for slice in string.gmatch(str, '([^' .. separator .. ']+)') do
        index = index + 1
        result[index] = slice
    end

    return result, index
end

-- Returns a table without trailing elements.
-- @param list - table
-- @param len - length of a table
-- @param skip_count - number of elements to skip
-- @return table
-- @return table length
local function skip_last(list, len, skip_count)
    local result = {}
    local index = 0

    if skip_count == nil then skip_count = 1 end

    while index + skip_count < len do
        index = index + 1
        result[index] = list[index]
    end

    return result, index
end

-- Returns a head of a table.
-- @param list - table
-- @param len - length of a table
-- @param take_count - number of elements to select
-- @return table
-- @return table length
local function take_first(list, len, take_count)
    local result = {}
    local index = 0

    if take_count == nil then take_count = 1 end

    while index < len and index < take_count do
        index = index + 1;
        result[index] = list[index]
    end

    return result, index
end

local function noremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap = true})
end

local function nnoremap(lhs, rhs) noremap('n', lhs, rhs) end

local function vnoremap(lhs, rhs) noremap('v', lhs, rhs) end

local function cnoremap(lhs, rhs) noremap('c', lhs, rhs) end

return {
    split = split,
    skip_last = skip_last,
    take_first = take_first,
    nnoremap = nnoremap,
    cnoremap = cnoremap,
    vnoremap = vnoremap
}
