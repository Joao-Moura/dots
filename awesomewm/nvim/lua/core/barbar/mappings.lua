local mapKey = require('utils').mapKey

-- Anterior/Próximo
mapKey('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
mapKey('n', '<A-.>', '<Cmd>BufferNext<CR>')

-- Re-ordenar anterior/próximo
mapKey('n', '<A-Left>', '<Cmd>BufferMovePrevious<CR>')
mapKey('n', '<A-Right>', '<Cmd>BufferMoveNext<CR>')

-- GOTO buffer
mapKey('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
mapKey('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
mapKey('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
mapKey('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
mapKey('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
mapKey('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
mapKey('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
mapKey('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
mapKey('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
mapKey('n', '<A-0>', '<Cmd>BufferLast<CR>')
