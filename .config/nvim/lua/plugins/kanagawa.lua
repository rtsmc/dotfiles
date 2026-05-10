return {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            theme = "wave",
            transparent = false,
            terminalColors = true,

            commentStyle = { italic = false },

            colors = {
                palette = {
                    -- Background / UI ink scale
                    sumiInk0 = "#101014",
                    sumiInk1 = "#14141A",
                    sumiInk2 = "#1B1B23",
                    sumiInk3 = "#181818",
                    sumiInk4 = "#252531",
                    sumiInk5 = "#303041",
                    sumiInk6 = "#7F8097",

                    -- Selection / search
                    waveBlue1 = "#223249",
                    waveBlue2 = "#2D4F67",

                    -- Diff backgrounds: kept muted so they don't overpower syntax
                    winterGreen = "#2B3328",
                    winterYellow = "#49443C",
                    winterRed = "#43242B",
                    winterBlue = "#252535",

                    -- VCS / non-diagnostic red-yellow-green
                    autumnGreen = "#8AC071",
                    autumnRed = "#F25A60",
                    autumnYellow = "#F0B862",

                    -- Diagnostics
                    samuraiRed = "#FF514A",
                    roninYellow = "#FFB45A",
                    waveAqua1 = "#73B8AA",
                    dragonBlue = "#80AFC6",

                    -- Main foregrounds
                    fujiWhite = "#E4E4E4",
                    oldWhite = "#D6D2C4",

                    -- Cooler, less warm comment gray
                    fujiGray = "#8A909D",

                    -- Syntax foregrounds: more visibly vibrant than the prior pass
                    oniViolet = "#B58BF4",
                    oniViolet2 = "#D4C7FF",
                    crystalBlue = "#84ADFF",
                    springViolet1 = "#B5AED8",
                    springViolet2 = "#B5C6F0",
                    springBlue = "#8AD0E8",
                    waveAqua2 = "#83D0C0",
                    springGreen = "#A8D86F",
                    boatYellow1 = "#BFA365",
                    boatYellow2 = "#E6BB6D",
                    carpYellow = "#FFD47A",
                    sakuraPink = "#FF92B6",
                    waveRed = "#FF7084",
                    peachRed = "#FF6D70",
                    surimiOrange = "#FFB06C",
                    katanaGray = "#8A9696",
                },

                theme = {
                    wave = {
                        ui = {
                            bg = "#181818",
                            bg_dim = "#14141A",
                            bg_m3 = "#101014",
                            bg_m2 = "#14141A",
                            bg_m1 = "#1B1B23",
                            bg_p1 = "#252531",
                            bg_p2 = "#303041",
                            bg_gutter = "#181818",

                            fg = "#E4E4E4",
                            fg_dim = "#D6D2C4",

                            bg_visual = "#223249",
                            bg_search = "#2D4F67",

                            float = {
                                bg = "#101014",
                                bg_border = "#101014",
                            },
                        },

                        syn = {
                            string = "#A8D86F",
                            variable = "none",
                            number = "#FF92B6",
                            constant = "#FF92B6",
                            identifier = "#FFD47A",
                            parameter = "#E4E4E4",
                            fun = "#84ADFF",
                            statement = "#B58BF4",
                            keyword = "#B58BF4",
                            operator = "#E6BB6D",
                            preproc = "#FF7084",
                            type = "#83D0C0",
                            regex = "#E6BB6D",
                            deprecated = "#8A9696",
                            comment = "#8A909D",
                            punct = "#B5C6F0",
                            special1 = "#8AD0E8",
                            special2 = "#FF7084",
                            special3 = "#FF6D70",
                        },

                        vcs = {
                            added = "#8AC071",
                            removed = "#F25A60",
                            changed = "#F0B862",
                        },

                        diag = {
                            error = "#FF514A",
                            warning = "#FFB45A",
                            info = "#73B8AA",
                            hint = "#80AFC6",
                        },

                        diff = {
                            add = "#2B3328",
                            delete = "#43242B",
                            change = "#252535",
                            text = "#49443C",
                        },
                    },
                },
            },

            overrides = function(colors)
                local p = colors.palette

                -- Much subtler indentation/block guides.
                local indent = "#25252C"
                local indent_scope = "#30303A"

                -- Subtler cursorline
                local cursorline = "#22232B"

                return {
                    Normal = { fg = p.fujiWhite, bg = "#181818" },
                    NormalNC = { fg = p.fujiWhite, bg = "#181818" },

                    SignColumn = { bg = "#181818" },
                    FoldColumn = { bg = "#181818" },
                    LineNr = { fg = p.sumiInk6, bg = "#181818" },
                    CursorLine = { bg = cursorline },
                    CursorLineNr = { fg = p.surimiOrange, bold = true },

                    NormalFloat = { fg = p.fujiWhite, bg = "#101014" },
                    FloatBorder = { fg = p.sumiInk6, bg = "#101014" },

                    Visual = { bg = p.waveBlue1 },
                    Search = { fg = p.fujiWhite, bg = p.waveBlue2 },
                    IncSearch = { fg = "#F2F2F2", bg = p.waveBlue2 },

                    -- Cooler, clearer comments
                    Comment = { fg = p.fujiGray },
                    ["@comment"] = { fg = p.fujiGray },
                    ["@comment.documentation"] = { fg = p.fujiGray },

                    -- Explicit syntax reinforcement so the vibrance is more visible
                    String = { fg = p.springGreen },
                    Character = { fg = p.springGreen },
                    Number = { fg = p.sakuraPink },
                    Boolean = { fg = p.sakuraPink },
                    Float = { fg = p.sakuraPink },
                    Constant = { fg = p.sakuraPink },

                    Function = { fg = p.crystalBlue },
                    Identifier = { fg = p.fujiWhite },

                    Statement = { fg = p.oniViolet },
                    Conditional = { fg = p.oniViolet },
                    Repeat = { fg = p.oniViolet },
                    Keyword = { fg = p.oniViolet },
                    Exception = { fg = p.oniViolet },

                    Operator = { fg = p.boatYellow2 },
                    Type = { fg = p.waveAqua2 },
                    StorageClass = { fg = p.waveAqua2 },
                    Structure = { fg = p.waveAqua2 },
                    Typedef = { fg = p.waveAqua2 },

                    PreProc = { fg = p.waveRed },
                    Include = { fg = p.waveRed },
                    Define = { fg = p.waveRed },
                    Macro = { fg = p.waveRed },
                    PreCondit = { fg = p.waveRed },

                    Special = { fg = p.springBlue },
                    SpecialChar = { fg = p.springBlue },
                    Tag = { fg = p.waveRed },
                    Delimiter = { fg = p.springViolet2 },

                    -- Treesitter groups
                    ["@string"] = { fg = p.springGreen },
                    ["@character"] = { fg = p.springGreen },
                    ["@number"] = { fg = p.sakuraPink },
                    ["@boolean"] = { fg = p.sakuraPink },
                    ["@constant"] = { fg = p.sakuraPink },
                    ["@constant.builtin"] = { fg = p.sakuraPink },

                    ["@function"] = { fg = p.crystalBlue },
                    ["@function.call"] = { fg = p.crystalBlue },
                    ["@function.builtin"] = { fg = p.springBlue },
                    ["@method"] = { fg = p.crystalBlue },
                    ["@method.call"] = { fg = p.crystalBlue },

                    ["@keyword"] = { fg = p.oniViolet },
                    ["@keyword.function"] = { fg = p.oniViolet },
                    ["@keyword.return"] = { fg = p.oniViolet },
                    ["@keyword.operator"] = { fg = p.oniViolet },
                    ["@conditional"] = { fg = p.oniViolet },
                    ["@repeat"] = { fg = p.oniViolet },

                    ["@operator"] = { fg = p.boatYellow2 },

                    ["@type"] = { fg = p.waveAqua2 },
                    ["@type.builtin"] = { fg = p.waveAqua2, italic = true },
                    ["@constructor"] = { fg = p.waveAqua2 },

                    ["@property"] = { fg = p.carpYellow },
                    ["@field"] = { fg = p.carpYellow },
                    ["@variable.member"] = { fg = p.carpYellow },
                    ["@parameter"] = { fg = p.fujiWhite },
                    ["@variable.parameter"] = { fg = p.fujiWhite },

                    ["@punctuation.delimiter"] = { fg = p.springViolet2 },
                    ["@punctuation.bracket"] = { fg = p.springViolet2 },
                    ["@punctuation.special"] = { fg = p.springBlue },

                    ["@tag"] = { fg = p.waveRed },
                    ["@tag.attribute"] = { fg = p.carpYellow },
                    ["@tag.delimiter"] = { fg = p.springViolet2 },

                    -- Diagnostics
                    DiagnosticError = { fg = p.samuraiRed },
                    DiagnosticWarn = { fg = p.roninYellow },
                    DiagnosticInfo = { fg = p.waveAqua1 },
                    DiagnosticHint = { fg = p.dragonBlue },

                    -- Git/VCS
                    GitSignsAdd = { fg = p.autumnGreen },
                    GitSignsChange = { fg = p.autumnYellow },
                    GitSignsDelete = { fg = p.autumnRed },

                    -- Subtle indent guides.
                    -- Covers indent-blankline.nvim v3, older indent-blankline,
                    -- mini.indentscope, and snacks.nvim indent.
                    IblIndent = { fg = indent, nocombine = true },
                    IblWhitespace = { fg = indent, nocombine = true },
                    IblScope = { fg = indent_scope, nocombine = true },

                    IndentBlanklineChar = { fg = indent, nocombine = true },
                    IndentBlanklineSpaceChar = { fg = indent, nocombine = true },
                    IndentBlanklineContextChar = { fg = indent_scope, nocombine = true },
                    IndentBlanklineContextStart = { sp = indent_scope, underline = true },

                    MiniIndentscopeSymbol = { fg = indent_scope },

                    SnacksIndent = { fg = indent },
                    SnacksIndentScope = { fg = indent_scope },
                }
            end,
        })

        vim.cmd("colorscheme kanagawa-wave")
    end,
}
