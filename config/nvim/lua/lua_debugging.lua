--[[
Contains all debugging utility functions used by me when writing a plugin.
--]]

function package_loaded_to_quickfix()
    local qf_list = {}
    local inspect = vim.inspect

    -- Iterate over package.loaded and format it for quickfix
    for name, module in pairs(package.loaded) do
        local entry = {
            -- text = string.format("%s: %s", name, inspect(module)) -- format the module name and its data
            text = string.format("%s: %s", name, module)
        }
        table.insert(qf_list, entry)
    end

    -- Set the quickfix list
    vim.fn.setqflist(qf_list, 'r')  -- 'r' flag replaces the current quickfix list

    -- Open the quickfix window
    vim.cmd("copen")
end

function reload_packages()
  -- NOTE: Some plugins might not work after this
  for name, module in pairs(package.loaded) do
    require('plenary.reload').reload_module(name, true)
  end
end

function reload_package(name)
  require('plenary.reload').reload_module(name, true)
end

