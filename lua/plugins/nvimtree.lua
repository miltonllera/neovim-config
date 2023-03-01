-- NVIM tree


local status, nvim_tree = pcall(require, "nvim-tree")
if (not status) then return end

nvim_tree.setup({
  -- Allow using gx
  disable_netrw = false,
  hijack_netrw = true,
  update_cwd = true,
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,

  view = {
    adaptive_size = false,
    width = 40,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  git = {
    enable = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          --  default = "",
          --  open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      }
    }
  },
  filters = {
    dotfiles = false,
  },
})

local status, nvim_tree_devicons = pcall(require, "nvim-web-devicons")
if (not status) then return end

nvim_tree_devicons.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    folder = {
      icon = "",
      color = "#428850",
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
