return {
  "luozhiya/fittencode.nvim",
  config = function()
    require("fittencode").setup {
      keymaps = {
        inline = {
          ["<S-CR>"] = "accept_all_suggestions",
          ["<C-e>"] = "accept_line",
          ["<C-i>"] = "accept_word",
          ["<C-u>"] = "revoke_line",
          ["<C-n>"] = "revoke_word",
          ["<c-\\>"] = "triggering_completion",
        },
        chat = {
          ["q"] = "close",
          ["[c"] = "goto_previous_conversation",
          ["]c"] = "goto_next_conversation",
          ["c"] = "copy_conversation",
          ["C"] = "copy_all_conversations",
          ["d"] = "delete_conversation",
          ["D"] = "delete_all_conversations",
        },
      },
    }
  end,
}
