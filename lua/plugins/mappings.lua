---@diagnostic disable: undefined-field

local function get_root()
  local buf_root = vim.b.astroroot
  if buf_root then return buf_root end

  local ok, astrocore = pcall(require, "astrocore")
  if ok then
    if astrocore.rooter and type(astrocore.rooter.resolve) == "function" then return astrocore.rooter.resolve() end
    if type(astrocore.get_root) == "function" then return astrocore.get_root() end
  end

  return vim.fn.getcwd()
end

return {
  {
    "numToStr/Comment.nvim",
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          -- Normal 模式
          maps.n["gcc"] = {
            function()
              return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
              )()
            end,
            expr = true,
            silent = true,
            desc = "Toggle comment line",
          }
          -- Visual 模式
          maps.x["gcc"] = {
            "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
            desc = "Toggle comment",
          }
        end,
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- 放大
          ["<C-=>"] = {
            function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end,
            desc = "Increase Neovide scale factor",
          },
          -- 缩小
          ["<C-->"] = {
            function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end,
            desc = "Decrease Neovide scale factor",
          },
          -- 重置
          ["<C-0>"] = {
            function() vim.g.neovide_scale_factor = 1.0 end,
            desc = "Reset Neovide scale factor",
          },
          ["<Leader>e"] = {
            function() _G.Snacks.explorer() end,
            desc = "Toggle Snacks Explorer",
          },
          ["<Leader>o"] = {
            function()
              if vim.bo.filetype == "snacks_picker_list" then
                vim.cmd.wincmd "p"
              else
                _G.Snacks.explorer.reveal()
              end
            end,
            desc = "Toggle Explorer Focus",
          },

          -- Float Terminal
          ["<Leader>fT"] = { function() _G.Snacks.terminal() end, desc = "Terminal (cwd)" },
          ["<Leader>ft"] = {
            function() _G.Snacks.terminal(nil, { cwd = get_root() }) end,
            desc = "Terminal (Root Dir)",
          },
          ["<C-/>"] = {
            function() _G.Snacks.terminal(nil, { cwd = get_root() }) end,
            desc = "Terminal (Root Dir)",
          },
          ["<C-_>"] = {
            function() _G.Snacks.terminal(nil, { cwd = get_root() }) end,
            desc = "which_key_ignore",
          },
          ["<C-S-v>"] = { '"+p', desc = "Paste from system clipboard" },

          ["<C-L>"] = { "<C-w>l", desc = "Move to right split" },
        },
        i = {
          ["<C-S-v>"] = { "<C-r>+", desc = "Paste from system clipboard" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
          ["<C-/>"] = {
            function() _G.Snacks.terminal(nil, { cwd = get_root() }) end,
            desc = "Terminal (Root Dir)",
          },
          ["<C-_>"] = {
            function() _G.Snacks.terminal(nil, { cwd = get_root() }) end,
            desc = "which_key_ignore",
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {},
      },
    },
  },
}
