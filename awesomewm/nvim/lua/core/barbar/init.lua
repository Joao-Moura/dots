--[[ vim.api.nvim_create_autocmd('WinClosed', {
    callback = function(tbl)
        vim.api.nvim_command('bdelete' .. tbl.buf)
    end,
    group = vim.api.nvim_create_augroup('barbar_close_buf', {})
}) ]]
