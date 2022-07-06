require('packer').init({
  max_jobs = 60,
})
return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  -- Completion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('configs.nvim-cmp').setup()
    end,
  })
  use({
    'L3MON4D3/LuaSnip',
    config = function()
      require('configs.luasnip').setup()
    end,
  })

  -- Colors and Themes
  use({
    'catppuccin/nvim',
    as = 'catppuccin',
  })
  use({
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        '*',
        '!packer',
      }, {
        names = false,
      })
    end,
  })

  -- Statusline and Visual Components
  use({
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  })
  use({
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
      'SmiteshP/nvim-gps',
    },
    config = function()
      require('configs.lualine').setup()
    end,
  })
  use({
    'SmiteshP/nvim-gps',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-gps').setup()
    end,
  })
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        buftype_exclude = { 'help', 'packer' },
      })
    end,
  })
  use({
    'petertriho/nvim-scrollbar',
    requires = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('configs.scrollbar').setup()
    end,
  })
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('configs.telescope').setup()
    end,
  })
  use({
    'stevearc/dressing.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
  })
  use({
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 40,
        },
      })
    end,
  })
  use('simnalamburt/vim-mundo')

  -- Productivity and Quality of Life
  use({
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  })
  use('machakann/vim-sandwich')
  use('ntpeters/vim-better-whitespace')
  use('schickling/vim-bufonly')
  use('AndrewRadev/inline_edit.vim')
  use({
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  })
  use('zhou13/vim-easyescape')
  use('AndrewRadev/splitjoin.vim')
  use('wsdjeg/vim-fetch')
  use({
    'vladdoster/remember.nvim',
    config = function()
      require('remember').setup({})
    end,
  })

  -- Programming
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('configs.nvim-treesitter').setup()
    end,
    run = ':TSUpdate',
  })
  use({
    'nvim-treesitter/playground',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    run = ':TSInstall query',
  })
  use({
    'ThePrimeagen/refactoring.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.refactoring').setup()
    end,
  })
  use({
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language('default', { prefer_single_line_comments = true })
    end,
  })
  use({
    'windwp/nvim-autopairs',
    requires = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('configs.nvim-autopairs').setup()
    end,
  })
  use('andymass/vim-matchup')
  use('RRethy/vim-illuminate')
  use({
    'AndrewRadev/linediff.vim',
    cmd = { 'Linediff', 'LinediffReset' },
  })

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    config = function() end,
  })
  use({
    'williamboman/nvim-lsp-installer',
    config = function()
      require('nvim-lsp-installer').setup({
        automatic_installation = true,
      })
      require('configs.lsp').setup()
    end,
  })
  use({
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require('configs.lsp-format')
    end,
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('configs.null-ls').setup()
    end,
  })
  use({
    'weilbith/nvim-code-action-menu',
    requires = {
      'neovim/nvim-lspconfig',
    },
    cmd = 'CodeActionMenu',
  })
  use({
    'simrat39/symbols-outline.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    cmd = {
      'SymbolsOutline',
      'SymbolsOutlineOpen',
      'SymbolsOutlineClose',
    },
  })
  use({
    'folke/lua-dev.nvim',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require('configs.lua-dev').setup()
    end,
  })
  use({
    'j-hui/fidget.nvim',
    config = function()
      require('configs.fidget').setup()
    end,
  })
  use({
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('configs.trouble').setup()
    end,
  })

  -- DAP
  use({
    'mfussenegger/nvim-dap',
    config = function()
      require('configs.dap').setup()
    end,
  })
  use({
    'rcarriga/nvim-dap-ui',
    requires = 'mfussenegger/nvim-dap',
    config = function()
      require('configs.dapui').setup()
    end,
  })
  use({
    'Pocco81/DAPInstall.nvim',
    requires = 'mfussenegger/nvim-dap',
    config = function()
      require('dap-install').setup()
    end,
    cmd = {
      'DIInstall',
      'DIUninstall',
      'DIList',
    },
  })
  use({
    'mfussenegger/nvim-dap-python',
    requires = 'mfussenegger/nvim-dap',
    config = function()
      require('configs.dap-python').setup()
    end,
    ft = { 'python' },
  })
  use({
    'leoluz/nvim-dap-go',
    requires = 'mfussenegger/nvim-dap',
    config = function()
      require('configs.dap-go').setup()
    end,
    ft = { 'go' },
  })

  -- Git
  use('tpope/vim-fugitive')
  use('gregsexton/gitv')
  use('knsh14/vim-github-link')
  use({
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('configs.gitsigns').setup()
    end,
  })

  -- CSS / SASS
  use('hail2u/vim-css3-syntax')
  use('cakebaker/scss-syntax.vim')

  -- Go
  use({
    'ray-x/go.nvim',
    config = function()
      local lsp_config = require('configs.lsp')
      require('go').setup({
        lsp_cfg = {
          capabilities = lsp_config.capabilities,
        },
        lsp_on_attach = lsp_config.on_attach,
      })
    end,
    ft = { 'go', 'godoc', 'gomod', 'gotmplhtml', 'gotexttmpl' },
  })
  use('gotgenes/golang-template.vim')

  -- HTML
  use('tmhedberg/matchit')
  use('othree/html5.vim')
  use('alvan/vim-closetag')

  -- Jenkinsfile
  use('martinda/Jenkinsfile-vim-syntax')

  -- GraphQL
  use('jparise/vim-graphql')

  -- JavaScript
  use('pangloss/vim-javascript')
  use('maxmellon/vim-jsx-pretty')

  -- LaTeX
  use('lervag/vimtex')

  -- Markdown
  use('godlygeek/tabular')
  use('plasticboy/vim-markdown')
  use({
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'pandoc.markdown', 'rmd' },
    run = 'cd app & yarn install',
  })

  -- Python
  use('tmhedberg/SimpylFold')
  use('hynek/vim-python-pep8-indent')
  use('vim-python/python-syntax')

  -- Terraform
  use('hashivim/vim-terraform')

  -- Thrift
  use('solarnz/thrift.vim')

  -- TOML
  use('cespare/vim-toml')

  -- TypeScript
  use('leafgarland/typescript-vim')
  use('peitalin/vim-jsx-typescript')
  use({
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('configs/nvim-lsp-ts-utils').setup()
    end,
  })

  -- Velocity
  use('lepture/vim-velocity')

  -- xonsh
  use('meatballs/vim-xonsh')
end)
