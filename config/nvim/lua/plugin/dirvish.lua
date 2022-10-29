local utils = require('../utils')

local function exec_cmd(cmd)
    local status_code = os.execute(cmd)

    if status_code ~= 0 then
        print(string.format('Non-zero status code [%d]: %s', status_code, cmd))
    end

    return status_code
end

-- Prompt whether the provided paths should be removed.
-- @param paths - table of strings
-- @param len - length of a table
-- @return boolean
local function prompt_paths_remove(paths, len)
    local prompt_paths = paths

    if len > 10 then
        prompt_paths = utils.take_first_n(paths, 10)
        prompt_paths[11] = string.format('and %d more', len - 10)
    end

    local confirmation = vim.fn.input({
        prompt = table.concat(prompt_paths, '\n') ..
            '\nDo you want to remove those files [y/n]? '
    })

    return confirmation == 'y';
end

-- Creates parent directories for given path if they do not exist.
-- @param path - string
-- @return number
local function create_parent_dirs(path)
    local chunks = utils.skip_last_n(utils.split(path, '/'))
    local path_head = '/' .. table.concat(chunks, '/') .. '/'

    return exec_cmd('mkdir -p ' .. path_head)
end

-- Move path to a new location.
-- @param path - string
-- @param new_path - string
-- @return number
local function path_move(path, new_path)
    local status = create_parent_dirs(new_path)
    local res, err = os.rename(path, new_path)

    if err then
        print(string.format('Could not move file or directory to %s\n%s', path,
                            err))
    end

    return res, err
end

-- Handle file rename for currently selected line.
local function current_line_file_move()
    local path = vim.fn.getline('.')

    if string.len(path) == 0 then return end

    local new_path = vim.fn.input({
        prompt = 'Move to: ',
        default = path,
        completion = 'file'
    })

    if (new_path == path) or (string.len(new_path) == 0) then return end

    path_move(path, new_path)
end

-- Handle file rename for paths in arglist.
local function argv_file_move(argc)
    local argv = vim.fn.argv()
    local index = 1

    print('Type "q" to exit.\n')

    while index <= argc do
        local path = argv[index]
        local prompt = string.format('[%d/%d] Move to: ', index, argc)
        local new_path = vim.fn.input({
            prompt = prompt,
            default = path,
            completion = 'file'
        })

        if new_path == 'q' then break end

        local is_path_valid = new_path ~= path or string.len(new_path) ~= 0

        if is_path_valid then
            local res = path_move(path, new_path)

            if res then vim.cmd('argdelete ' .. path) end
        end

        index = index + 1
    end
end

-- Remove provided path.
-- @param path - string
-- @return status code
local function path_remove(path)
    local cmd = 'rm -rf ' .. path
    return exec_cmd(cmd)
end

-- Handle remove file for currently selected line.
local function current_line_file_remove()
    local path = vim.fn.getline('.')

    if string.len(path) == 0 then return end

    if not prompt_paths_remove({ path }, 1) then return end

    path_remove(path)
end

-- Handle remove file for paths in arglist.
local function argv_file_remove(argc)
    local argv = vim.fn.argv()
    local index = 1

    if not prompt_paths_remove(argv, argc) then return end

    while index <= argc do
        local path = argv[index]

        if string.len(path) > 0 then
            if path_remove(path) == 0 then
                vim.cmd('argdelete ' .. path)
            end
        end

        index = index + 1
    end
end

-- Return path to currently viewed directory in Dirvish.
-- Ensures the path contains traling slash.
-- @return nil or string
local function get_bufname_path()
    local bufpath = vim.fn.expand('%')

    if string.sub(bufpath, -1) ~= '/' then
        return nil
    end

    return bufpath
end

_G.usr.dirvish_create = function()
    local bufpath = get_bufname_path()

    if bufpath == nil then return end

    local path = vim.fn.input({
        prompt = 'Create: ',
        default = bufpath,
        completion = 'file'
    })

    if string.len(path) == 0 then return end

    if string.sub(path, -1) == '/' then
        exec_cmd('mkdir -p ' .. path)
    else
        create_parent_dirs(path)
        io.close(io.open(path, 'w'))
    end

    vim.cmd('Dirvish %')
end

_G.usr.dirvish_rename = function()
    if get_bufname_path() == nil then return end

    local argc = vim.fn.argc()

    if argc == 0 then
        current_line_file_move()
    else
        argv_file_move(argc)
    end

    vim.cmd('Dirvish %')
end

_G.usr.dirvish_remove = function()
    if get_bufname_path() == nil then return end

    local argc = vim.fn.argc()

    if argc == 0 then
        current_line_file_remove()
    else
        argv_file_remove(argc)
    end

    vim.cmd('Dirvish %')
end
