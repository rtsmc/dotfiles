require("compile")

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
vim.o.cursorline = true

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
vim.keymap.set("n", '<leader>r', "<cmd>Compile last<CR>")

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

-- mini pick keybinds
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")


----------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            'rebelot/kanagawa.nvim',
            opts = {
                compile = true,
                undercurl = true,
                colors = {
                    palette = {
                        sumiInk0 = "#1c1c1d",
                        sumiInk1 = "#181818",
                        sumiInk2 = "#181818",
                        sumiInk3 = "#181818",
                        sumiInk4 = "#282828",
                        sumiInk5 = "#343434",
                        sumiInk6 = "#68686b"
                    }
                },
            }
        },
        { 'nvim-mini/mini.icons' },
        { 'nvim-mini/mini.pick' },
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {},
            dependencies = { { "nvim-mini/mini.icons", opts = {} } },
            lazy = false,
        },
        {
            'Saghen/blink.cmp',
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = '1.*',
            opts = {
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
            }
        },
        { 'OXY2DEV/markview.nvim' },
        { 'dgagn/diagflow.nvim' },
        {
            'folke/snacks.nvim',
            opts = {
                indent = {
                    enabled = true,
                    filter = function(buf)
                        local excluded_ft = { "racket" }
                        return not vim.tbl_contains(excluded_ft, vim.bo[buf].filetype)
                        and vim.bo[buf].buftype == ""
                    end,
                }
            }
        },
        { 'folke/zen-mode.nvim' },
        {
            'lervag/vimtex',
            config = function()
                vim.g.vimtex_view_method = "zathura_simple"
                vim.g.vimtex_compiler_method = "tectonic"
            end
        },
        { 'nvim-treesitter/nvim-treesitter' },
        { 'mfussenegger/nvim-dap' },
        { 'neovim/nvim-lspconfig' },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "kanagawa" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})

vim.cmd.colorscheme "kanagawa"

require "mini.pick".setup()
-- require "nvim-treesitter.configs".setup()

require 'diagflow'.setup()
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
-- nvim-dap configuration
----------------------------------------------------------------------------------
local dap = require("dap")
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

----------------------------------------------------------------------------------
-- Langugae Servers
----------------------------------------------------------------------------------
vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "ruff", "racket_langserver", "vtsls" })

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
