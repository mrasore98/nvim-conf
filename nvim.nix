{
  vim = {
    opts = {
      number = true;
      relativenumber = true;
      wrap = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>qq";
        action = ":qa<CR>";
        desc = "Quit All";
      }
      {
        mode = ["n" "i"];
        key = "c-s";
        action = ":w<CR>";
        desc = "Write";
      }
    ];

    diagnostics = {
      enable = true;
      config = {
        signs = true;
        underline = true;
        update_in_insert = false;
      };
    };

    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
    };

    statusline.lualine.enable = true;
    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<leader>bd";
        cycleNext = "S-l";
        cyclePrevious = "S-h";
      };
    };
    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader> ";
        liveGrep = "<leader>/";
      };
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    filetree = {
      nvimTree.enable = true;
    };

    terminal = {
      # TODO: Match terminal colorscheme to theme
      toggleterm = {
        enable = true;
        lazygit.enable = true;
        mappings.open = "C-/";
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      lspconfig.enable = true;
      mappings = {
        codeAction = "<leader>ca";
        goToDefinition = "<leader>gd";
      };
      presets = {
        # Python
        ty.enable = true;
        ruff.enable = true;
        # Rust
        rust-analyzer.enable = true;
        # Nix
        nixd.enable = true;
        nil.enable = true;
      };
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      bash.enable = true;
      clang.enable = true;
      json.enable = true;
      markdown.enable = true;
      nix.enable = true;
      python.enable = true;
      typst.enable = true;
    };

    visuals = {
      nvim-web-devicons.enable = true;
      nvim-scrollbar.enable = true;
    };

    notes = {
      todo-comments.enable = true;
    };

    autopairs.nvim-autopairs.enable = true;
    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;
    notify.nvim-notify.enable = true;

    dashboard = {
      dashboard-nvim.enable = true;
      dashboard-nvim.setupOpts = {theme = "doom";};
    };

    mini = {
      ai.enable = true;
      surround.enable = true;
    };

    git.enable = false;
  };
}
