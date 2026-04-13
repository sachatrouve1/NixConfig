{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.lsd
    pkgs.fzf
  ];

  programs.fish = {
    enable = true;

    plugins = [
    {
      name = "pure";
      src = pkgs.fishPlugins.pure.src;
    }
    ];

    shellInit = ''
      # Pure prompt colors (must be set before pure loads)
      set -g pure_color_danger "ff6b6b"
      set -g pure_color_success "51cf66"
      set -g pure_color_warning "fcc419"
    '';

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1 # Skip venv prompt processing

      # fzf key bindings
      fzf --fish | source

      # Pure prompt configuration
      set -g pure_symbol_prompt "❯"
      set -g pure_enable_container_detection false
      set -g pure_show_cmd_duration true
      set -g pure_show_exit_code true
      set -g pure_prompt_on_new_line true
      set -g async_prompt_functions _pure_prompt_git
      set -g pure_show_numbered_git_indicator true
      set -g pure_show_jobs true
      set -g pure_enable_nixdevshell false
      set -g pure_show_subsecond_command_duration false
      set -g fish_transient_prompt true
      set -g pure_show_prefix_root_prompt true
      set -g fish_key_bindings fish_vi_key_bindings
    '';

    shellAliases = {
      sysupdate = "sudo nixos-rebuild switch --flake ~/.nixconfig/";
      flakeupdate = "cd ~/.nixconfig && nix flake update";
      clean = "nix-env --delete-generations old -p ~/.local/state/nix/profiles/profile && sudo nix-collect-garbage -d";
      searchpkg = "nix search nixpkgs ";
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
      ltr = "eza --icons=auto --tree";
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
