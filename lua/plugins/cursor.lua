return {
  {
    lazy = false,
    enabled = true,
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
  },
  {
    enabled = true,
    "mvllow/modes.nvim",
    dir = "/Volumes/EXT1_SSD/Users/user1/Projects/Other/modes.nvim",
    opts = {
      colors = {
        insert = "#66a4e7",
        normal = "#98bc74",
        visual = "#b36cd3",
        copy = "#f5c359",
        delete = "#c75c6a",
        replace = "#245361",
        change = "#c75c6a", -- Optional param, defaults to delete
        format = "#c79585",
      },
      -- Set opacity for cursorline and number background
      line_opacity = 0.15,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = false,

      -- Enable sign column highlights to match cursorline
      set_signcolumn = false,


    }
  }
}
