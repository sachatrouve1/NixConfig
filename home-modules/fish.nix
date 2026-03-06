{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.lsd
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1 # Skip venv prompt processing

      # Pure prompt configuration
      set -g pure_symbol_prompt "❯"
      set -g pure_symbol_virtualenv "󱔎"
      set -g pure_symbol_git_unpushed ""
      set -g pure_symbol_git_unpulled ""
      set -g pure_symbol_git_dirty ""
      set -g pure_symbol_git_clean "✓"
      set -g pure_color_prompt "magenta"
      set -g pure_color_user "yellow"
      set -g pure_color_dir "cyan"
      set -g pure_color_git_branch "green"
      set -g pure_color_git_unpushed "red"
      set -g pure_color_git_unpulled "blue"
      set -g pure_color_git_dirty "yellow"
      set -g pure_color_path "blue"
      set -g pure_color_cmd_duration "yellow"
      set -g pure_show_path true
      set -g pure_show_user true
      set -g pure_show_cmd_duration true
      set -g pure_show_exit_code true
      set -g pure_prompt_on_new_line true
    '';

    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.nixconfig/ --impure";
      clean = "sudo nix-collect-garbage -d";
      dockerclean = "sudo docker system prune -a";
      journalclean = "sudo journalctl --vacuum-time=7d";
      vpniut = "sudo openfortivpn u-vpn-plus.unilim.fr --saml-login";
      bdd = "nvim +':DBUI' ";
      avante = "nvim -c 'lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)'";
      ls = "eza -1 --icons=auto";
      c = "clear";
      l = "eza -lh --icons=auto";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld = "eza -lhD --icons=auto";
      lt = "eza --icons=auto --tree";
      ".." = "cd ..";
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      mkdir = "mkdir -p";
      search = "sudo find . -iname ";
      searchin = "sudo grep -rnw . -e ";
      setwallpaper = "~/.local/share/bin/set_wallpaper.sh ";
      startweb = "sudo systemctl start httpd && systemctl status httpd && sudo systemctl start mariadb && systemctl status mariadb";
      rmnot = "sudo ~/.local/share/bin/rmnot.sh";
      topng = "~/.local/share/bin/topng.sh";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };
}
