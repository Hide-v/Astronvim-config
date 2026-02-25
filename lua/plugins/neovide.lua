if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "Maple_Mono_NF_CN:h10",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure variables
        neovide_theme = "auto",
        neovide_opacity = 0.85,
        neovide_scale_factor = 1.0,
        neovide_padding_left = 5,

        neovide_cursor_animation_length = 0.1,
        neovide_cursor_trail_size = 0.8,
        neovide_cursor_antialiasing = true,
        neovide_refresh_rate = 165,
        neovide_scroll_animation_length = 0.3,

        neovide_cursor_vfx_mode = "pixiedust",
        neovide_cursor_vfx_particle_lifetime = 1.2,
        neovide_cursor_vfx_particle_density = 20.0,
        neovide_cursor_vfx_particle_speed = 15.0,
      },
    },
  },
}
