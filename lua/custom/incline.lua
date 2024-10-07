local M = {}

M.renderWithIconName = function()
  local helpers = require("incline.helpers")
  local devicons = require("nvim-web-devicons")

  require("incline").setup({
    window = {
      padding = 0,
      margin = { horizontal = 0, vertical = 0 },
    },
    render = function(props)
      -- vim.fn.expand("%:t")
      -- vim.fn.fnamemodify()

      -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      -- local display_name = string.format("%s/%s", vim.fn.expand("%:h:t"), filename)
      -- local parent_dir = vim.fn.expand("%:h:t")

      -- https://neovim.io/doc/user/cmdline.html#filename-modifiers
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p:.")
      local display_name = filename

      -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p:h")
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified
      local buffer = {
        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
        " ",
        { display_name, gui = modified and "bold,italic" or "bold" },
        " ",
        guibg = "#363944",
      }
      return buffer
    end,
  })
end

-- TODO: Errors for lsps that don't have file structure component. Need to loop through and omit
-- the lsps that don't have it.
M.renderWithNavic = function()
  local navic = require("nvim-navic")
  local helpers = require("incline.helpers")
  local devicons = require("nvim-web-devicons")

  require("incline").setup({
    window = {
      padding = 0,
      margin = { horizontal = 0, vertical = 0 },
    },
    render = function(props)
      -- :h:t gets parent directory
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local display_name = string.format("%s/%s", vim.fn.expand("%:h:t"), filename)
      if filename == "" then
        filename = "[No Name]"
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified
      local res = {
        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
        " ",
        { display_name, gui = modified and "bold,italic" or "bold" },
        guibg = "#44406e",
      }
      if props.focused then
        for _, item in ipairs(navic.get_data(props.buf) or {}) do
          table.insert(res, {
            { " > ", group = "NavicSeparator" },
            { item.icon, group = "NavicIcons" .. item.type },
            { item.name, group = "NavicText" },
          })
        end
      end
      table.insert(res, " ")
      return res
    end,
  })
end

return M
