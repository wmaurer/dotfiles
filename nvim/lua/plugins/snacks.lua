return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          notifications = {
            win = {
              input = {
                keys = {
                  ["y"] = { "yank", mode = { "n" } },
                },
              },
              list = {
                keys = {
                  ["y"] = { "yank", mode = { "n" } },
                },
              },
            },
          },
        },
      },
    },
  },
}
