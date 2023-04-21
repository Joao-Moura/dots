local mapKey = require('utils').mapKey

local lspconfig = require("lspconfig")

local nlspsettings = require("nlspsettings")

local null_ls = require("null-ls")

local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

nlspsettings.setup({
    config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
    append_default_schemas = true,
    ignored_servers = {},
    loader = "json"
})

function on_attach(client, bufnr)
    mapKey("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    mapKey("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    mapKey("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local servers = {
    "lua_ls",
    "pyright",
    "jsonls",
    "rust_analyzer",
}

mason.setup()
mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

for _, server in pairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    lspconfig[server].setup(opts)
end

null_ls.setup({
    debug = false,
})

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Right>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, {
            "i",
            "s",
        }),
    }),

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
            })[entry.source.name]
            return vim_item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = 'luasnip' }
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

    experimental = {
        ghost_text = true,
    },
})
