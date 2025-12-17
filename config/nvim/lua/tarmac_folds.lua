
  -- lua/tarmac_folds.lua
  local ts = vim.treesitter

  local M = {}
  local testcase_query -- cached query object

  local function get_testcase_query()
    if testcase_query then
      return testcase_query
    end

    -- Try to parse the query; fail quietly if tarmac isn’t available
    local ok, q = pcall(function()
      local ts_query = ts.query
      return (ts_query.parse or ts_query.parse_query)(
        'tarmac',
        '(testcase) @tc'
      )
    end)

    if not ok then
      return nil
    end

    testcase_query = q
    return q
  end

  local function compute_testcase_ranges(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    local query = get_testcase_query()
    if not query then
      return {}
    end

    local ok, parser = pcall(ts.get_parser, bufnr, 'tarmac')
    if not ok then
      return {}
    end

    local tree = parser:parse()[1]
    local root = tree:root()

    local starts = {}
    for _, node, _ in query:iter_captures(root, bufnr, 0, -1) do
      local row = node:range()
      table.insert(starts, row) -- 0-based row
    end

    table.sort(starts)
    if #starts == 0 then
      return {}
    end

    local last_line = vim.api.nvim_buf_line_count(bufnr)
    local ranges = {}

    for i, row in ipairs(starts) do
      local start_lnum = row + 1
      local next_row = starts[i + 1]
      local end_lnum = next_row and next_row or last_line
      table.insert(ranges, { start_lnum = start_lnum, end_lnum = end_lnum })
    end

    return ranges
  end

  function _G.TarmacFoldExpr()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Cache per buffer, invalidated on change
    local cache = vim.b.tarmac_fold_cache
    if not cache or cache.tick ~= vim.b.changedtick then
      cache = {
        tick = vim.b.changedtick,
        ranges = compute_testcase_ranges(bufnr),
      }
      vim.b.tarmac_fold_cache = cache
    end

    local lnum = vim.v.lnum

    for _, r in ipairs(cache.ranges) do
      if lnum == r.start_lnum then
        return '>1'
      elseif lnum > r.start_lnum and lnum <= r.end_lnum then
        return '='
      end
    end

    return 0
  end

  function M.setup()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.TarmacFoldExpr()'
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 0
  end

  return M


