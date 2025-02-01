local lfs  = require("lfs")
local fs   = require("luarocks.fs")
local util = require("luarocks.util")
local dir  = require("luarocks.dir")
local path = require("luarocks.path")
local cfg  = require("luarocks.core.cfg")

local M    = {}

---Driver function for the "autotools" build back-end.
---@param rockspec table the loaded rockspec.
---@return boolean | nil, string: true if no errors occurred,
--- nil and an error message otherwise.
function M.run(rockspec, no_install)
    -- get rockspec
    assert(not rockspec.type or rockspec:type() == "rockspec")
    local build = rockspec.build
    local build_variables = build.variables or {}
    local autotools_variables = build_variables.autotools or {}
    util.variable_substitutions(build_variables, rockspec.variables)

    local configure = dir.path(fs.current_dir(), "configure")
    if not fs.is_file(configure) then
        local command = "autoreconf -vif"
        if os.execute(command) ~= 0 then
            return nil, "failed to run: " .. command
        end
    end

    -- do build and install
    local do_build, do_install
    if rockspec.format_is_at_least and rockspec:format_is_at_least("3.0") then
        do_build   = (build.build_pass == nil) and true or build.build_pass
        do_install = (build.install_pass == nil) and true or build.install_pass
    else
        do_build = true
        do_install = true
    end

    local libdir = path.lib_dir(rockspec.name, rockspec.version)
    local luadir = path.lua_dir(rockspec.name, rockspec.version)
    if do_build then
        autotools_variables.CFLAGS = autotools_variables.CFLAGS or cfg.variables.CFLAGS or "",
        if autotools_variables.LUA_INCDIR != nil then
            autotools_variables.CFLAGS = string.format(
                [[%s -I%s]],
                autotools_variables.CFLAGS,
                autotools_variables.LUA_INCDIR or cfg.variables.LUA_INCDIR,
            )
        end
        autotools_variables.PREFIX = autotools_variables.PREFIX or cfg.home_tree or cfg.root_dir or ""
        autotools_variables.LIBDIR = autotools_variables.LIBDIR or libdir or ""
        autotools_variables.LUADIR = autotools_variables.LUADIR or luadir or ""
        local cmd = string.format(
            [[CFLAGS='%s' ./configure --prefix='%s' --libdir='%s' --datadir='%s']],
            autotools_variables.CFLAGS,
            autotools_variables.PREFIX,
            autotools_variables.LIBDIR,
            autotools_variables.LUADIR,
        )
        for _, command in ipairs { cmd, "make clean", "make" } do
            if os.execute(command) ~= 0 then
                return nil, "failed to run: " .. command
            end
        end
        if do_install and not no_install then
            -- local command = "make install"
            -- if os.execute(command) ~= 0 then
            --     return nil, "failed to run: " .. command
            -- end
            for _, libs in ipairs { ".libs", "_libs" } do
                local fd = io.open(dir.path(fs.current_dir(), libs))
                if fd then
                    for file in lfs.dir(dir.path(fs.current_dir(), libs)) do
                        local ext = file:match("%.([^.]+)")
                        if ext == "so" or ext == "dll" or ext == "dylib" then
                            fs.copy(dir.path(fs.current_dir(), libs, file), libdir)
                        end
                    end
                    fd:close()
                end
            end
        end
        fs.copy_contents(dir.path(fs.current_dir(), "lua"), luadir)
    end
    return true, ""
end

return M
