return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        local signs = { Error = " ", Warn = " ", Hint = "󰄛 ", Info = "󰄛 " }
        for type, icon in pairs(signs) do
            vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type, numhl = "DiagnosticSign" .. type })
        end

        require("cmp").setup({
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },

            mapping = {
                ["<Down>"] = require("cmp").mapping.select_next_item(),
                ["<Up>"] = require("cmp").mapping.select_prev_item(),
                ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
                ["<C-Space>"] = require("cmp").mapping.complete(),
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path"},
            },

            window = {
                completion = require("cmp").config.window.bordered(),
                documentation = require("cmp").config.window.bordered(),
            },
        })

        require("mason").setup({})
        require("mason-lspconfig").setup({
            handlers = { lsp_zero.default_setup }
        })
    end
}

