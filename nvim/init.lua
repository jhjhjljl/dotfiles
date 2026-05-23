-- basics
vim.opt.number = true
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")


-- theme
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
vim.cmd("highlight MatchParen guibg=NONE guifg=NONE gui=NONE")


-- plugins
vim.pack.add{
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" }
}


-- telescope
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = require("telescope.actions").close
            }
        }
    }
}
local builtin = require("telescope.builtin")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>h", builtin.help_tags)


-- autopairs
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" }
})


-- lsp and autocompletion
vim.lsp.enable("pyrefly")
vim.opt.signcolumn = "yes"

local cmp = require("cmp")
cmp.setup({
    completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" },
    }
})
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})

vim.api.nvim_create_autocmd("CursorHoldI", {
    callback = function()
        vim.lsp.buf.signature_help()
    end,
})

vim.opt.updatetime = 500


-- file tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local config = {
    sort = {
        sorter = "case_sensitive",
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
            }
        }
    }
}
require("nvim-tree").setup(config)
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>")

