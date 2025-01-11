return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "File Explorer" },
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "File Explorer" },
    },
    opts = {
      hijack_cursor = true,
      filters = {
        custom = { "^.git$" },
        dotfiles = false,
      },
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      git = {
        enable = true,
        show_on_dirs = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = false,
      },
      view = {
        adaptive_size = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local mappings = {
          { "<2-LeftMouse>", api.node.open.edit, "Open" },
          { "<cr>", api.node.open.edit, "Open" },
          { "<2-RightMouse>", api.tree.change_root_to_node, "CD" },
          { "<C-]>", api.tree.change_root_to_node, "CD" },
          { "<C-r>", api.tree.reload, "Refresh" },
          { "<C-v>", api.node.open.vertical, "Open: Vertical Split" },
          { "<C-x>", api.node.open.horizontal, "Open: Horizontal Split" },
          { "h", api.node.navigate.parent_close, "Close Directory" },
          { "l", api.node.open.edit, "Open" },
          { "H", api.node.navigate.parent, "Parent Directory" },
          { "J", api.node.navigate.sibling.next, "Next Sibling" },
          { "K", api.node.navigate.sibling.prev, "Previous Sibling" },
          { "L", api.node.open.no_window_picker, "Open: No Window Picker" },
          { "-", api.tree.change_root_to_parent, "Up" },
          { "a", api.fs.create, "Create File Or Directory" },
          { "x", api.fs.cut, "Cut" },
          { "c", api.fs.copy.node, "Copy" },
          { "p", api.fs.paste, "Paste" },
          { "d", api.fs.remove, "Delete" },
          { "D", api.fs.trash, "Trash" },
          { "r", api.fs.rename, "Rename" },
          { "R", api.fs.rename_full, "Rename: Full Path" },
          { "e", api.fs.rename_basename, "Rename: Basename" },
          { "yy", api.fs.copy.absolute_path, "Copy Absolute Path" },
          { "y$", api.fs.copy.filename, "Copy Name" },
          { "ye", api.fs.copy.basename, "Copy Basename" },
          { "Y", api.fs.copy.relative_path, "Copy Relative Path" },
          { "gx", api.node.run.system, "Run System" },
          { "g?", api.tree.toggle_help, "Help" },
          { ".", api.node.run.cmd, "Run Command" },
          { "q", api.tree.close, "Close" },
          { "<leader>tb", api.tree.toggle_no_buffer_filter, "Toggle Filter: No Buffer" },
          { "<leader>tg", api.tree.toggle_git_clean_filter, "Toggle Filter: Git Clean" },
          { "<leader>td", api.tree.toggle_hidden_filter, "Toggle Filter: Dotfiles" },
          { "<leader>ti", api.tree.toggle_gitignore_filter, "Toggle Filter: Git Ignore" },
          { "<leader>tc", api.tree.toggle_custom_filter, "Toggle Filter: Hidden" },
        }
        for _, mapping in ipairs(mappings) do
          vim.keymap.set("n", mapping[1], mapping[2], {
            desc = mapping[3],
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          })
        end
      end,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      ignored_filetypes = { "NvimTree" },
      ignored_buftypes = { "nofile", "quickfix", "prompt" },
      resize_mode = { silent = true },
    },
    keys = function()
      local split = require("smart-splits")
      return {
        { "<C-h>", split.move_cursor_left, mode = { "n" }, desc = "Move cursor to left pane" },
        { "<C-j>", split.move_cursor_down, mode = { "n" }, desc = "Move cursor to bottom pane" },
        { "<C-k>", split.move_cursor_up, mode = { "n" }, desc = "Move cursor to top pane" },
        { "<C-l>", split.move_cursor_right, mode = { "n" }, desc = "Move cursor to right pane" },
        { "<M-Left>", split.resize_left, mode = { "n" }, desc = "Resize pane to the left" },
        { "<M-Down>", split.resize_down, mode = { "n" }, desc = "Resize pane to the bottom" },
        { "<M-Up>", split.resize_up, mode = { "n" }, desc = "Resize pane to the top" },
        { "<M-Right>", split.resize_right, mode = { "n" }, desc = "Resize pane to the right" },
        { "<leader>wh", split.swap_buf_left, mode = { "n" }, desc = "Swap with left pane" },
        { "<leader>wj", split.swap_buf_down, mode = { "n" }, desc = "Swap with bottom pane" },
        { "<leader>wk", split.swap_buf_up, mode = { "n" }, desc = "Swap with top pane" },
        { "<leader>wl", split.swap_buf_right, mode = { "n" }, desc = "Swap with right pane" },
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "LazyFile",
    dependencies = { "kevinhwang91/promise-async" },
    keys = function()
      local ufo = require("ufo")
      return {
        { "]z", ufo.goNextClosedFold, mode = "n", desc = "Next Fold" },
        { "[z", ufo.goPreviousClosedFold, mode = "n", desc = "Prev Fold" },
        { "zp", ufo.peekFoldedLinesUnderCursor, mode = "n", desc = "Peek fold" },
      }
    end,
    opts = {
      enable_get_fold_virt_text = true,
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
      },
      preview = {
        mappings = {
          scrollB = "<C-b>",
          scrollF = "<C-f>",
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          switch = "zp",
        },
        win_config = {
          winblend = 0,
        },
      },
      provider_selector = function(_, filetype, buftype)
        local ufo = require("ufo")
        local function fallback_provider(bufnr, err, provider)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return ufo.getFolds(bufnr, provider)
          else
            return require("promise").reject(err)
          end
        end
        local function treesitter_folds(bufnr)
          local res = ufo.getFolds(bufnr, "treesitter")
          if res == nil then
            return nil
          end
          local folds = {} ---@type table<integer,UfoFoldingRange>
          for _, fold in ipairs(res) do
            if not folds[fold.startLine] then
              folds[fold.startLine] = fold
            end
          end
          return folds
        end
        -- only use indent until a file is opened
        return (filetype == "" or buftype == "nofile") and "indent"
          or function(bufnr)
            return ufo
              .getFolds(bufnr, "lsp")
              :thenCall(function(res) ---@param res UfoFoldingRange[]
                if res == nil then
                  return nil
                end
                local ts_folds = treesitter_folds(bufnr)
                if ts_folds then
                  for _, fold in ipairs(res) do
                    if ts_folds[fold.startLine] then
                      fold.endLine = ts_folds[fold.startLine].endLine
                      fold.endCharacter = nil
                    end
                  end
                end
                return res
              end)
              :catch(function(err)
                return fallback_provider(bufnr, err, "treesitter")
              end)
              :catch(function(err)
                return fallback_provider(bufnr, err, "indent")
              end)
          end
      end,
      fold_virt_text_handler = function(vtext, slnum, elnum, width, truncate, ctx)
        ---@see https://github.com/kevinhwang91/nvim-ufo/issues/26
        local end_patterns = { "end[,)]*", "[%])}]+[,;]?", "['\"`]", "</[%w.]*>" }
        local endline = vim.trim(vim.fn.getline(elnum))
        local end_vtext = {}
        for _, pattern in ipairs(end_patterns) do
          if endline:find(pattern) == 1 then
            end_vtext = ctx.get_fold_virt_text(elnum)
            end_vtext[1][1] = end_vtext[1][1]:gsub("^%s+", "")
            break
          end
        end
        table.insert(vtext, {
          (" %s %d "):format(require("app.icons").ui.Fold, elnum - slnum),
          "UfoFoldedEllipsis",
        })
        vim.list_extend(vtext, end_vtext)
        return vtext
      end,
    },
  },
}
