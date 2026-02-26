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
    '';

    plugins = [
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
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
      rmnot = "sudo ~/rmnot.sh";
    };
  };

    programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };

}
