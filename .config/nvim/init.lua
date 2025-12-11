-- ==========================================================================
--  🏛️ NEOVIM CONFIGURATION (MINIMALIST & PORTABLE)
--  Theme: Gruvbox Material | Manager: Lazy.nvim | Logic: Lua
-- ==========================================================================

-- 1. OPÇÕES NATIVAS (O BÁSICO)
vim.g.mapleader = " "       -- Tecla Leader é o ESPAÇO
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true           -- Números na esquerda
opt.relativenumber = true   -- Números relativos (bom para saltos no Vim)
opt.mouse = "a"             -- Mouse funciona
opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema (wl-clipboard)
opt.breakindent = true      -- Quebra de linha inteligente
opt.undofile = true         -- Salva histórico de desfazer mesmo fechando o arquivo
opt.ignorecase = true       -- Busca ignora maiúsculas
opt.smartcase = true        -- ...a menos que você digite uma maiúscula
opt.signcolumn = "yes"      -- Coluna de sinais sempre visível (evita pulos)
opt.updatetime = 250        -- Atualização rápida da interface
opt.timeoutlen = 300        -- Tempo para atalhos compostos
opt.splitright = true       -- Splits verticais abrem na direita
opt.splitbelow = true       -- Splits horizontais abrem embaixo
opt.termguicolors = true    -- Cores verdadeiras (24-bit)
opt.scrolloff = 8           -- Mantém 8 linhas de margem ao rolar
opt.tabstop = 4             -- Tab = 4 espaços
opt.shiftwidth = 4
opt.expandtab = true        -- Converte Tab em Espaços

-- 2. BOOTSTRAP DO LAZY.NVIM (GERENCIADOR DE PLUGINS)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. LISTA DE PLUGINS
require("lazy").setup({

  -- >> TEMA (GRUVBOX MATERIAL)
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard" -- Fundo escuro profundo
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_bold = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- >> BARRA DE STATUS (LUALINE)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "gruvbox-material",
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- >> BUSCADOR (TELESCOPE) - Essencial
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep (Texto)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    end,
  },

  -- >> SYNTAX HIGHLIGHTING (TREESITTER)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "python", "javascript" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  -- >> FILE EXPLORER (NEO-TREE) - Visual estilo VSCode
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Tree)" },
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        filtered_items = { visible = true }, -- Mostra arquivos ocultos (.config)
      }
    }
  },

  -- >> COMENTÁRIOS RÁPIDOS (GCC)
  { "numToStr/Comment.nvim", opts = {} },

  -- >> AUTOCOMPLETE & LSP (A "Inteligência")
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",           -- Instalador de Servidores
      "williamboman/mason-lspconfig.nvim", -- Conector Mason -> LSP
      "hrsh7th/nvim-cmp",                  -- Motor de Autocomplete
      "hrsh7th/cmp-nvim-lsp",              -- Fonte LSP
      "L3MON4D3/LuaSnip",                  -- Snippets
    },
    config = function()
      -- Setup Mason (Instalador)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "bashls", "pyright" }, -- Garante Lua, Bash e Python
        handlers = {
          function(server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')[server_name].setup({
              capabilities = capabilities
            })
          end,
        }
      })

      -- Configuração do Autocomplete (CMP)
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter confirma
          ['<Tab>'] = cmp.mapping.select_next_item(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end
  },
})

-- 4. ATALHOS GERAIS
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Esc limpa a busca
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Sair" })

-- Atalhos de navegação entre janelas (Ctrl + hjkl)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
