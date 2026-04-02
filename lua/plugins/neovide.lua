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
      g = { -- configure vim.g variables
        -- 透明度与间距
        neovide_opacity = 0.85,
        neovide_scale_factor = 1.0,
        neovide_padding_left = 5,

        -- 动画与渲染
        neovide_cursor_animation_length = 0.1,
        neovide_cursor_trail_size = 0.8,
        neovide_cursor_antialiasing = true,
        neovide_refresh_rate = 165,
        neovide_scroll_animation_length = 0.3,

        -- 特效强化
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_cursor_vfx_particle_lifetime = 1.2,
        neovide_cursor_vfx_particle_density = 20.0,
        neovide_cursor_vfx_particle_speed = 15.0,
      },
    },
  },
  init = function()
    local is_linux = vim.loop.os_uname().sysname == "Linux"
    if is_linux then
      vim.g.neovide_theme = "auto"

      local function sync_wallbash_mode()
        local mode_file = vim.fn.expand "~/.cache/hyde/wallbash/shell-colors"
        local f = io.open(mode_file, "r")
        if f then
          local content = f:read "*all"
          f:close()
          local pry1 = content:match "wallbash_pry1='([^']+)'"
          if pry1 then
            local r_val = tonumber(pry1:sub(2, 3), 16)
            -- 使用 schedule 确保在主题插件准备就绪后再执行
            vim.schedule(function()
              if r_val and r_val > 128 then
                vim.o.background = "light"
                pcall(vim.cmd.colorscheme, "catppuccin-latte")
              else
                vim.o.background = "dark"
                pcall(vim.cmd.colorscheme, "catppuccin-mocha")
              end
            end)
          end
        end
      end

      -- 1. 初次启动同步
      sync_wallbash_mode()

      -- 2. 文件监听器
      local wallbash_cache_path = vim.fn.expand "~/.cache/hyde/wallbash/"
      if vim.fn.isdirectory(wallbash_cache_path) == 1 then
        local w = (vim.uv or vim.loop).new_fs_event()
        if w then
          w:start(
            wallbash_cache_path,
            {},
            vim.schedule_wrap(function(err, fname)
              if not err and fname == "shell-colors" then sync_wallbash_mode() end
            end)
          )
        end
      end
    end
  end,
}
