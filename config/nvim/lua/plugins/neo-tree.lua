return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal float toggle<CR>', {})
        vim.keymap.set('n', '<leader>b', ':Neotree buffers reveal float toggle<CR>', {})
        vim.keymap.set('n', '<leader>g', ':Neotree git_status reveal float toggle<CR>', {})
        
        require("neo-tree").setup({
        	popup_border_style = "rounded",
        	filesystem = {
          		filtered_items = {
            			visible = false,
            			hide_dotfiles = false,
            			hide_gitignored = false,
            		}
            	},
        })
    end
}

