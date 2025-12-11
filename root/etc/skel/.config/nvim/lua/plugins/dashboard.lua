return {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = {
                    "⠄⠄⠄⢀⠄⠄⢀⠠⢂⣵⣾⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠂⠄",
                    "⡀⠄⠈⢀⡠⡌⣴⣾⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⠄⢀⣤⡎⠄⠄",
                    "⠁⠄⢀⣠⣤⣤⣤⣈⠈⠄⠄⠄⠄⠄⠄⠄⠠⢊⢄⣽⡟⠄⠄⠄",
                    "⠆⢰⠋⠄⠄⠄⠙⢿⣿⣦⡄⠄⣣⣤⣶⣯⣤⡔⣿⡟⡀⠄⠄⠄",
                    "⣷⣷⣀⢔⠄⠄⠤⣼⣿⣿⣿⢀⢩⣽⣿⣿⣿⣿⣟⡄⠄⠄⠄⠄",
                    "⣿⣿⣿⣷⣦⣲⣾⣿⣿⣿⡿⢸⣾⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⣀",
                    "⣿⣿⣿⣿⣿⣿⣾⣿⣻⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⣋⣍⡈⠙",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⡀⣀⣿⡇⣀",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣠⣾⣿⡴⠋",
                    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⠏⠄⠄",
                    "",
                },

                shortcut = {
                    { desc = " Lazy", group = "WarningMsg", key = "L", action = "Lazy" },
                    { desc = "  Neotree", group = "WarningMsg", key = "N", action = "Neotree" },
                    { desc = "  Hide/Show pet", group = "WarningMsg", key = "P", action = "PetsHideToggle" },
                },

                packages = { enable = true },
                project = { enable = false },
                mru = { enable = true, limit = 10, icon = " ", label = "Last opened files:", cwd_only = false },
                footer = {},
            }
        })
    end
}
