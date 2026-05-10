return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            local nts = require("nvim-treesitter")

            nts.setup({
                -- Optional. This is the default-style install location.
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            -- Replace old ensure_installed = { ... }
            nts.install({
                "bash",
                "c",
                "css",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "toml",
            })

            -- Enable Treesitter features using Neovim's native APIs.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
                callback = function(args)
                    local bufnr = args.buf
                    local ft = vim.bo[bufnr].filetype

                    -- Start Treesitter highlighting for this buffer.
                    -- pcall prevents errors for filetypes without a parser.
                    pcall(vim.treesitter.start, bufnr, ft)

                    -- Optional: use Treesitter indentation when available.
                    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
