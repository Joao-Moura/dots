local g = vim.g

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
    renderer = {
        indent_markers = {enable = true},
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    }
}
require('nvim-tree').setup(args)
