local builtin = require('telescope.builtin')

-- Basic Telescope configuration
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
  },
  extensions = {
      ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
      }
  }
}
