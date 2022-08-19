require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_setup = true,
  ignore_buffer_on_setup = true,
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "s", cb = tree_cb("split") }, --tree_cb and the cb property are deprecated
        { key = "v", cb = tree_cb("vsplit") }, --tree_cb and the cb property are deprecated
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

