require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_setup = true,
  ignore_buffer_on_setup = true,
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "s", action = "split" },
        { key = "v", action = "vsplit" },
        { key = "p", action = "print_path", action_cb = print_node_path },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

