----------------------------------------------------------------------------------
-- Vim Options
----------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.netrw_bufsettings = 'nu rnu'
vim.o.nu = true
vim.o.relativenumber = true
-- tab/indent related
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- other
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.clipboard = "unnamedplus"
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.cursorline = true

vim.o.termguicolors = true
vim.o.cursorcolumn = false

-- built in terminal settings
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
})

----------------------------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------------------------
vim.keymap.set("n", "<C-e>", vim.cmd.Oil)
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", '<leader>qf', vim.diagnostic.setqflist)

-- small terminal
vim.keymap.set("n", "<space>st", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end)

-- formatting keybind
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set({ 'n', 'x' }, 'gq', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

----------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------

vim.g.vimtex_view_method = "zathura_simple"
vim.g.vimtex_compiler_method = "tectonic"

vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons",
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
    "https://github.com/dgagn/diagflow.nvim",
    "https://github.com/lervag/vimtex",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/sainnhe/edge",
    "https://github.com/vague-theme/vague.nvim",
    "https://github.com/nanotech/jellybeans.vim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/catppuccin/nvim",
}, { load = true, confirm = false })

require("mini.icons").setup()
require("oil").setup()

require("blink.cmp").setup({
    signature = { enabled = true },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
            auto_show = true,
            draw = {
                columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
            },
        },
    },
    sources = {
        default = { 'lsp', 'snippets', 'path', 'omni' },
    }
})

require("diagflow").setup()
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '●',
            [vim.diagnostic.severity.WARN] = '●',
            [vim.diagnostic.severity.HINT] = '●',
            [vim.diagnostic.severity.INFO] = '●',
        },
    }
})

----------------------------------------------------------------------------------
-- Colors
----------------------------------------------------------------------------------

vim.g.edge_style = "default"
vim.g.edge_better_performance = 1

vim.cmd.colorscheme "edge"

----------------------------------------------------------------------------------
-- Langugae Servers
----------------------------------------------------------------------------------
vim.lsp.enable({
    "lua_ls",
    "clangd",
    "basedpyright",
    "ruff",
    "racket_langserver",
    "vtsls",
    "rust_analyzer",
    "mojo"
})

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "hint",
                    reportUnusedImport = "hint",
                    reportUnusedClass = "hint",
                    reportUnusedFunction = "hint",
                    reportPrivateImportUsage = "none",
                    reportPrivateLocalImportUsage = "none",
                    reportMissingTypeStubs = "none",
                },
            },
        },
    }
})

vim.lsp.config("ruff", {
    settings = {
        lint = {
            enable = false
        }
    }
})
