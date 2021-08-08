local utils = require('utils')
local lfs = require('lfs')

-- Prompt whether the provided paths should be removed.
-- @param paths - table of strings
-- @param len - length of a table
-- @return boolean
local function prompt_paths_remove(paths, len)
    local prompt_paths = paths

    if len > 10 then
        prompt_paths = utils.take_first(paths, 10)
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
-- @return nil
local function create_parent_dirs(path)
    local path_chunks, length = utils.split(path, '/\\')

    if length < 2 then return nil end

    -- Determine the closest existing parent directory.
    local probe_chunks, probe_lvl = utils.skip_last(path_chunks, length)

    while probe_lvl > 0 do
        local test_path = '/' .. table.concat(probe_chunks, '/') .. '/'
        local res, err = lfs.attributes(test_path)

        -- The path at this level exists.
        if res then break end

        local ch, lv = utils.skip_last(probe_chunks, probe_lvl)
        probe_chunks = ch
        probe_lvl = lv
    end

    -- The whole path does not exist, doesn't seem like the path
    -- is correct.
    if probe_lvl == 0 then return nil end

    -- Get the first parent directory level that should be created.
    local level = probe_lvl + 1
    while level < length do
        local len_diff = length - level
        local dir_path = table.concat(utils.skip_last(path_chunks, length,
                                                      len_diff), '/')
        local res, err = lfs.mkdir('/' .. dir_path .. '/')

        if res == nil then
            print(string.format('Could not create directory at %s\n%s',
                                dir_path, err))
            break
        end

        level = level + 1
    end
end

-- Remove provided path recursively if needed.
-- @param path - string
-- return nil
local function remove_dir(path)
    for file in lfs.dir(path) do
        local filepath = path .. '/' .. file

        if not (file == '.' or file == '..') then
            local attrs = lfs.attributes(filepath)

            if attrs.mode == 'file' then
                os.remove(filepath)
            elseif attrs.mode == 'directory' then
                remove_dir(filepath)
            end
        end
    end

    return os.remove(path)
end

-- Move path to a new location.
-- @param path - string
-- @param new_path - string
-- @return nil
local function path_move(path, new_path)
    create_parent_dirs(new_path)

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

    create_parent_dirs(new_path)
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

        local is_path_invalid = new_path == path or string.len(new_path) == 0

        if not is_path_invalid then
            local res = path_move(path, new_path)

            if res then vim.cmd('argdelete ' .. path) end
        end

        index = index + 1
    end
end

-- Remove provided path.
-- @param path - string
-- @return first result
-- @return second error
local function path_remove(path)
    local is_dir = string.sub(path, -1) == '/'
    local res, err

    if is_dir then
        local r, e = remove_dir(path)
        res = r
        err = e
    else
        local r, e = os.remove(path)
        res = r
        err = e
    end

    if not res then
        print(string.format('Could not delete file or directory at %s\n%s',
                            path, err))
    end

    return res, err
end

-- Handle remove file for currently selected line.
local function current_line_file_remove()
    local path = vim.fn.getline('.')

    if string.len(path) == 0 then return end

    if not prompt_paths_remove({path}, 1) then return end

    path_remove(path)
end

-- Return path to currently viewed directory in Dirvish.
-- Ensures the path contains traling slash.
-- @return nil or string
local function get_bufname_path()
    local bufpath = vim.fn.expand('%')
    local has_trailing_slash = string.sub(bufpath, -1) == '/'

    if not has_trailing_slash then
        local res, err = lfs.attributes(bufpath);

        -- Not a directory.
        if res.mode ~= 'directory' then
            print('Current Dirvish buffer is not a directory.')
            return nil
        end
        -- Error when reading attributes.
        if err then
            print('Couldn\'t determine type of the file %s\n%s', bufpath, err);
            return nil
        end

        return bufpath .. '/'
    end

    return bufpath
end

-- Handle remove file for paths in arglist.
local function argv_file_remove(argc)
    local argv = vim.fn.argv()
    local index = 1

    if not prompt_paths_remove(argv, argc) then return end

    while index <= argc do
        local path = argv[index]

        if string.len(path) > 0 then
            local res = path_remove(path)

            if res then vim.cmd('argdelete ' .. path) end
        end

        index = index + 1
    end
end

_G.usr.dirvish = {
    create = function()
        local bufpath = get_bufname_path()

        if bufpath == nil then return end

        local path = vim.fn.input({
            prompt = 'Create: ',
            default = bufpath,
            completion = 'file'
        })

        if string.len(path) == 0 then return end

        create_parent_dirs(path)

        if string.sub(path, -1) == '/' then
            lfs.mkdir(path)
        else
            io.close(io.open(path, 'w'))
        end

        vim.cmd('Dirvish %')
    end,
    rename = function()
        if get_bufname_path() == nil then return end

        local argc = vim.fn.argc()

        if argc == 0 then
            current_line_file_move()
        else
            argv_file_move(argc)
        end

        vim.cmd('Dirvish %')
    end,
    remove = function()
        if get_bufname_path() == nil then return end

        local argc = vim.fn.argc()

        if argc == 0 then
            current_line_file_remove()
        else
            argv_file_remove(argc)
        end

        vim.cmd('Dirvish %')
    end
}
