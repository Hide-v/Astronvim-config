if not vim.g.neovide then return {} end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "Maple Mono:h10",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1.0,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        -- Animation effects
        neovide_cursor_animation_length = 0.13,
        neovide_cursor_trail_length = 0.8,
        neovide_cursor_anitialiasing = true,
        neovide_cursor_vfx_mode = "pixiedust", -- options "railgun、torpedo、pixiedust etc."
      },
    },
  },
}
