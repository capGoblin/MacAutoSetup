---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    -- Diagnostics configuration
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        winbar = "%=%m %f", -- Your custom winbar
      },
      g = { -- vim.g.<key>
        -- VSCode specific settings from your config
        loaded_nvim_lsp = vim.g.vscode and 1 or nil,
        loaded_mason = vim.g.vscode and 1 or nil,
        loaded_mason_lspconfig = vim.g.vscode and 1 or nil,
      },
    },
    -- Mappings
    mappings = {
      n = {
        -- Your custom mappings from LazyVim
        ["<Leader>sx"] = { function() require("telescope.builtin").resume() end, desc = "Resume Telescope" },
        ["<C-d>"] = { "<C-d>zz", desc = "Move half down and center" },
        ["<C-u>"] = { "<C-u>zz", desc = "Move half up and center" },
        ["n"] = { "nzzzv", desc = "Recenter after next search result" },
        ["N"] = { "Nzzzv", desc = "Recenter after previous search result" },
        ["<Leader>p"] = { '"_dP', desc = "Paste without affecting register" },

        -- Standard AstroNvim buffer navigation
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
      },
    },
  },
}
