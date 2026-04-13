{ config, pkgs, ... }:
{
  imports = [
    home-modules/hyprland.nix
    home-modules/fish.nix
    home-modules/librewolf.nix
    home-modules/lazyvim/lazyvim.nix
    home-modules/vscode/vscode.nix
    home-modules/git.nix
    home-modules/java.nix
  ];

  home.username = "sacha";
  home.homeDirectory = "/home/sacha";

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    gcc
    rustup
    cmake
    rustlings
    nodejs
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
    python313
    python313Packages.pip
    luarocks
    libtool
    ispell
    copilot-language-server
    graphviz
    libxml2
    typstPackages.octique
    imagemagick
    htop
    ncdu
    bat
    git
    wget
    bat
    fastfetch
    zoxide
    fzf
    jq
    cliphist
    brightnessctl
    pamixer
    cava
    udiskie
    tree
    eza pavucontrol
    caffeine-ng
    spotify-player
    docker
    zip
    unzip
    unrar
    foot
    vim
    gnome-keyring
    difftastic
    nmap
    qwen-code
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
    nosql-booster
    vt-cli
    pnpm
    whatweb
    weechat
    nudoku
    libqalculate
    ngrok
    fwupd
    obs-cli

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
    firefox
    vesktop
    discord
    spotify
    feh
    kdePackages.okular
    kdePackages.kruler
    jetbrains.idea
    libreoffice-fresh
    mongodb-compass
    qbittorrent
    pinta
    ryubing
    supertuxkart
    gimp
    element-desktop
    lutris
    wireshark
    audacity
    vlc
    kdePackages.kleopatra
    tor-browser
    proton-vpn
    zap
    obs-studio
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
