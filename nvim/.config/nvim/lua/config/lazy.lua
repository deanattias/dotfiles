-- lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Bootstrap lazy.nvim
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim and its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Auto-completion
    { import = "lazyvim.plugins.extras.coding.cmp" },

    -- Auto-closing brackets and quotes
    { import = "lazyvim.plugins.extras.coding.autopairs" },

    -- Snippets
    { import = "lazyvim.plugins.extras.coding.snippets" },

    -- Formatting
    { import = "lazyvim.plugins.extras.formatting.prettier" }, -- For JS/TS
    { import = "lazyvim.plugins.extras.formatting.black" },    -- For Python

    -- Linting
    { import = "lazyvim.plugins.extras.linting.eslint" },      -- For JS/TS

    -- Language Support
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.prisma" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- Treesitter for enhanced syntax highlighting
    { import = "lazyvim.plugins.extras.ui.treesitter" },

    -- Debugging
    { import = "lazyvim.plugins.extras.dap.core" },

    -- Telescope and extensions
    { import = "lazyvim.plugins.extras.editor.telescope" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },

    -- Git integration
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },

    -- File explorer
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
    },

    -- Productivity tools
    { "folke/which-key.nvim" },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },

    -- Terminal integration
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup({
          open_mapping = [[<c-\>]],
          direction = "float",
        })
      end,
    },

    -- Code execution
    {
      "CRAG666/code_runner.nvim",
      cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
      config = function()
        require("code_runner").setup({
          -- Configuration here
        })
      end,
    },

    -- Testing
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-vim-test",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-python"),
            require("neotest-go"),
            require("neotest-vim-test")({
              ignore_file_types = { "python", "go" },
            }),
          },
        })
      end,
    },

    -- Tailwind CSS colorizer
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      config = function()
        require("tailwindcss-colorizer-cmp").setup({
          color_square_width = 2,
        })
      end,
    },

    -- Surround
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end,
    },

    -- Indentation guides
    {
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        show_current_context = true,
        show_current_context_start = true,
      },
    },

    -- Markdown preview
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app && npm install",
      ft = { "markdown" },
      cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    },

    -- LuaSnip and friendly snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },

    -- Additional plugins can be added here
    { import = "plugins" },
  },
  defaults = {
    lazy = false,  -- Disable lazy loading by default
    version = false,  -- Always use the latest git commit
  },
  install = { colorscheme = { "gruvbox", "tokyonight" } },
  checker = { enabled = true },  -- Automatically check for plugin updates
  performance = {
    rtp = {
      -- Disable some runtime plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Custom highlight for visual selection
vim.cmd("highlight Visual ctermbg=0 guibg=#6441A5")