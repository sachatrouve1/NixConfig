{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.lsd
  ];

  programs.zsh = {
    enable = true;

    completionInit = ''
      autoload -Uz compinit
      compinit -C
    '';
    
    zprof.enable = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    # .zshrc
    initContent = ''
      # pywal
      # (cat ~/.cache/wal/sequences &)

      # Enable Powerlevel10k instant prompt. Should stay close to the top.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Configuration of powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Configuration of historySubstringSearch
      # zmodload zsh/terminfo
      # bindkey "$terminfo[kcuu1]" history-substring-search-up
      # bindkey "$terminfo[kcud1]" history-substring-search-down
      #bindkey '^[[A' history-substring-search-up
      #bindkey '^[OA' history-substring-search-up
      #bindkey '^[[B' history-substring-search-down
      #bindkey '^[OB' history-substring-search-down

      # Ctrl + Arrows
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word

      # Ctrl + Backspace : del left word
      bindkey "^H" backward-kill-word
      bindkey "^[^H" backward-kill-word
      bindkey "^[[3;5~" kill-word  # parfois nécessaire

      # Ctrl + Delete : del right word
      bindkey "^[[3;5~" kill-word
    '';

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.nixconfig/ --impure";
      searchpkg = "nix search nixpkgs ";
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
