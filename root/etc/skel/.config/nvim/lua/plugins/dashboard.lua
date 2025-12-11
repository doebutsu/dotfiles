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

                shortcut = {},
                packages = { enable = true },
                project = { enable = false },
                mru = { enable = true, limit = 10, icon = " ", label = "Last opened files:", cwd_only = false },
                footer = {},
            }
        })
    end
}
