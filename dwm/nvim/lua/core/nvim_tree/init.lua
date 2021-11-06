local g = vim.g

g.nvim_tree_indent_markers = 1
g.nvim_tree_icons = {
    default = '',
    git = {
        staged = "S",
        renamed = "R",
        untracked = "U",
        deleted = "D",
        ignored = "I",
        modified = "M",
    },
    folder = {
        default = "",
        open = "",
        empty = "0",
        empty_open = "0",
        symlink = "",
        symlink_open = "",
    },
}

local args = {
    auto_close = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    }
}
require('nvim-tree').setup(args)
