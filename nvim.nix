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

    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
    };

    statusline.lualine.enable = true;
    tabline.nvimBufferline = {enable = true;};
    telescope.enable = true;

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
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      bash.enable = true;
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
    clipboard.enable = true;

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
