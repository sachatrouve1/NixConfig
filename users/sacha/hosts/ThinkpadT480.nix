{ userName, pkgs, ... }:
{
  imports = [
    ../../../home-modules/base.nix
    ../../../home-modules/features/gaming.nix
    ../../../home-modules/features/hyprland.nix
    ../../../home-modules/features/librewolf.nix
    ../../../home-modules/features/lazyvim/lazyvim.nix
    ../../../home-modules/features/vscode/vscode.nix
    ../../../home-modules/features/direnv.nix
  ];

  home = {
    stateVersion = "25.11";
    username = userName;
    homeDirectory = "/home/${userName}";

    packages = with pkgs; [
      fd
      ripgrep
      exfat
      cmake
      python314
      tree-sitter
      vscode-langservers-extracted
      twig-language-server
      nixd
      nixfmt
      alejandra
      jdt-language-server
      vue-language-server
      prettier
      clang-tools
      javaPackages.compiler.temurin-bin.jdk-25
      live-server
      sqlcmd
      gnumake
      luarocks
      libtool
      ispell
      copilot-language-server
      graphviz
      libxml2
      typstPackages.octique
      imagemagick
      fzf
      jq
      cliphist
      networkmanagerapplet
      udiskie
      pamixer
      cava
      tree
      eza
      pavucontrol
      caffeine-ng
      spotify-player
      zip
      unzip
      unrar
      foot
      vim
      difftastic
      nmap
      lazygit
      lazydocker
      metasploit
      exploitdb
      ettercap
      docker-init
      dive
      openfortivpn
      tldr
      lsof
      vt-cli
      pnpm
      whatweb
      weechat
      libqalculate
      antigravity-cli
      claude-code
      ffmpeg
      p7zip
      yt-dlp
      cabextract
      d2
      killall
      tetris
      adwaita-fonts
      localsend
      (pkgs.writeShellScriptBin "pdftotext" ''
        for file in "''$@"; do
        if [ -f "''$file" ]; then
        name="''${file%.*}"
        echo "Converting ''$file to ''$nom.txt"
        ${pkgs.haskellPackages.pdftotext}/bin/pdftotext.hs text "''$file" > "''$name.txt"
        else
        echo "Erreur : ''$file is not a valid file."
        fi
        done
        echo "Done"
      '')

      nemo
      vesktop
      discord
      spotify
      feh
      kdePackages.okular
      kdePackages.kruler
      jetbrains.idea
      jetbrains.phpstorm
      libreoffice
      qbittorrent
      pinta
      gimp
      element-desktop
      wireshark
      vlc
      kdePackages.kleopatra
      obs-studio
      proton-vpn
      protontricks
      inkscape
      seahorse
      chromium
      stellarium
      # audacity
    ];
  };

  services.playerctld.enable = true;
}
