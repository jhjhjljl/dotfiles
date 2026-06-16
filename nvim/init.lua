-- basics
vim.opt.number = true
vim.opt.linebreak = true 
vim.opt.breakindent = true 
vim.opt.backup = false
vim.opt.swapfile = false 
vim.opt.writebackup = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader><Up>", ":m .-2<CR>==")
vim.keymap.set("n", "<leader><Down>", ":m .+1<CR>==")
vim.keymap.set({"n", "v"}, "d", '"_d')
vim.keymap.set("n", "x", '"_x')


-- plugins 
vim.pack.add{
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/seblyng/roslyn.nvim" }
}


-- theme
vim.cmd("colorscheme everforest")


-- telescope
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<Esc>"] = require("telescope.actions").close 
            }
        }
    }
}
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = { "^%.git/" }
    })
end)
vim.keymap.set("n", "<leader>g", function()
    builtin.live_grep({
        additional_args = { "--hidden", "--glob", "!.git" }
    })  
end)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>h", builtin.help_tags)


-- autopairs
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" }
})


-- lsp and autocompletion
vim.lsp.config("*", {
    root_markers = { ".git" }
})
vim.lsp.enable("clangd")
vim.lsp.enable("roslyn")
vim.lsp.enable("pyrefly")

vim.lsp.config("emmet", {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = { "html", "htmldjango" }
})
vim.lsp.enable("emmet")

vim.lsp.config("css", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css" }
})
vim.lsp.enable("css")

vim.lsp.config("typescript", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { 
        "typescript", 
        "javascript", 
        "typescriptreact", 
        "javascriptreact" 
    }
})
vim.lsp.enable("typescript")

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
vim.opt.updatetime = 500


-- file tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local config = {
    git = {
        enable = false
    },
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


-- weird python bracket opening fix
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.indentexpr = "python#GetIndent(v:lnum,1)"
    end,
})

