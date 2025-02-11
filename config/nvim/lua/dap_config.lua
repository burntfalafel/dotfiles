-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb
local dap = require("dap")
-- dap.adapters.gdb = {
--   type = "executable",
--   command = "gdb",
--   args = { "--interpreter=dap", "--quiet", "--args", "/home/easwad01/.local/fm_scripts/run_test.sh", "--eval-command", "set print pretty on" }
-- }

-- dap.configurations.cpp = {
--     {
--         name = 'Run executable (GDB)',
--         type = 'gdb',
--         request = 'launch',
--         -- This requires special handling of 'run_last', see
--         -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
--         program = function()
--             local path = vim.fn.input({
--                 prompt = 'Path to executable: ',
--                 default = vim.fn.getcwd() .. '/',
--                 completion = 'file',
--             })

--             return (path and path ~= '') and path or dap.ABORT
--         end,
--     },
--     {
--         name = 'Run executable with arguments (GDB)',
--         type = 'gdb',
--         request = 'launch',
--         -- This requires special handling of 'run_last', see
--         -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
--         program = function()
--             local path = vim.fn.input({
--                 prompt = 'Path to executable: ',
--                 default = vim.fn.getcwd() .. '/',
--                 completion = 'file',
--             })

--             return (path and path ~= '') and path or dap.ABORT
--         end,
--         args = function()
--             local args_str = vim.fn.input({
--                 prompt = 'Arguments: ',
--             })
--             return vim.split(args_str, ' +')
--         end,
--     },
--     {
--         name = 'Attach to process (GDB)',
--         type = 'gdb',
--         request = 'attach',
--         processId = require('dap.utils').pick_process,
--     },
-- }

-- Define the adapter
dap.adapters.gdb = {
  type = "executable",
  command = "/home/easwad01/.local/fm_scripts/run_test.sh", -- Path to your modified script
  args = {}, -- No additional arguments needed here
}

-- Define the configuration
dap.configurations.cpp = {
  {
    name = "Launch with run_test.sh",
    type = "gdb", -- Matches the adapter name
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}', -- The current working directory
    stopOnEntry = false, -- Set to true to stop at the entry point
    args = {}, -- Arguments passed to the executable
    setupCommands = {
      {
        text = "-enable-pretty-printing", -- Enable pretty-printing for GDB
        description = "Enable GDB pretty printing",
        ignoreFailures = false,
      },
    },
  },
}


dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = '/home/easwad01/.local/usr/nvim/.virtualenvs/debugpy/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end
local dap = require('dap')
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
require("dapui").setup()
