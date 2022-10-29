local utils = require('./utils')

-- negative path pattern
local pattern = '[^\'"`%s*+]'

local sh_prog = vim.fn.fnamemodify(vim.fn.expand('$MYVIMRC'), ':h') .. '/lua/cmp.sh'

-- extract cWORD behind the cursor
local function get_path_from_line(line, column)
    -- column - cursor position
    local sub_end = column - 1
    local sub_start = sub_end
    local char = string.sub(line, sub_start, sub_start)
    
    while sub_start > 1 do
        if string.find(char, pattern) then
            sub_start = sub_start - 1
            char = string.sub(line, sub_start, sub_start)
        else
            break
        end
    end

    if not string.find(char, pattern) then
        sub_start = sub_start + 1
    end

    local path = string.sub(line, sub_start, sub_end)
    local valid = (string.find(path, '^~?/') or string.find(path, '^..?/')) == 1

    return valid and path or nil
end

local function get_base_path(path)
    local char = string.sub(path, 1, 1)

    if char == '/' then
        return path
    elseif char == '~' then
        return vim.fn.fnamemodify(path, ':p')
    else
        return vim.fn.fnamemodify(vim.fn.expand('%:p:h') .. '/' .. path, ':p')
    end
end

-- extract search_dir and search_str
local function get_search_params(path)
    local base_path = get_base_path(path)
    local last_char = string.sub(path, -1)
    local has_search_str = (last_char ~= '/' and last_char ~= '~' and last_char ~= '.')

    local segments = utils.split(base_path, '/')
    local search_str = ''

    if has_search_str then
        search_str = segments[#segments]
        table.remove(segments)
    end

    if #segments == 0 then
        return '/', search_str
    end

    return '/' .. table.concat(segments, '/') .. '/', search_str
end

-- execute search command and return lines from stdout
local function search_cmd(search_dir, search_str)
    local cmd = sh_prog .. ' "' .. search_str .. '" "' .. search_dir .. '" ' .. (#search_dir + 1)

    local file = assert(io.popen(cmd, 'r'))
    local result = assert(file.read(file, 'a'))
    file.close(file)

    if result == '' then
        return {}
    end

    return utils.split(result, '\n')
end

local function path_completion(line, column)
    -- return early if nothing to complete
    if column == 1 or string.len(line) == 0 then
        return ''
    end

    local path = get_path_from_line(line, column)

    -- if path is invalid return early
    if path == nil then
        return ''
    end

    local search_dir, search_str = get_search_params(path)
    local completion_items = search_cmd(search_dir, search_str)

    vim.fn.complete(column - #search_str, completion_items)

    return ''
end

return path_completion
