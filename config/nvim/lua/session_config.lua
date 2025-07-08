local opts = {
    auto_create = true,
    auto_restore = true,
    auto_restore_last_session = false,
    auto_save = true,
    auto_session_git_auto_restore_on_branch_change = true,
    enabled = true,
    git_use_branch_name = true,
    lazy_support = true,
    log_level = "error",
    root_dir = "/home/easwad01/.local/usr/nvim/sessions/"
}
require('auto-session').setup(opts)
