{ config, userName, pkgs, ... }:
{
  imports = [
    ../../../home-modules/base.nix
    ../../../home-modules/features/gaming.nix
    ../../../home-modules/features/hyprland.nix
    ../../../home-modules/features/librewolf.nix
    ../../../home-modules/features/lazyvim/lazyvim.nix
    ../../../home-modules/features/vscode/vscode.nix
    ../../../home-modules/features/udisk.nix
    ../../../home-modules/features/direnv.nix
  ];

  home.stateVersion = "25.11";

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  services.playerctld.enable = true;

  home.packages = with pkgs; [
    cmake
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
    gnome-keyring
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
    nudoku
    libqalculate
    ngrok
    claude-code

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

    vesktop
    discord
    spotify
    feh
    kdePackages.okular
    kdePackages.kruler
    jetbrains.idea
    libreoffice-still
    mongodb-compass
    qbittorrent
    pinta
    gimp
    element-desktop
    wireshark
    audacity
    vlc
    kdePackages.kleopatra
    tor-browser
    obs-studio
    thunderbird
  ];

  home.sessionVariables = {
    ANTHROPIC_BASE_URL = "http://localhost:11434";
    ANTHROPIC_AUTH_TOKEN = "ollama";
  };
}
