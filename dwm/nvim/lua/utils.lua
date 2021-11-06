local M = {}

function M.mapKey(mode, lhs, rhs)
    local opt = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

return M
