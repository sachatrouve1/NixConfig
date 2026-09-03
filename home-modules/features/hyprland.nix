{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland-qtutils
    hyprpicker
    hyprlock
    hypridle
    hyprsunset
    hyprcursor
    hyprshade
    xdg-desktop-portal-hyprland
    gvfs
    qt5.qtwayland
    qt6.qtwayland

    waybar
    rofi
    wofi
    pywal
    pywalfox-native
    grim
    slurp
    wl-clipboard
    awww
    swaynotificationcenter
    wlogout
    nwg-look
    nwg-displays
    papirus-icon-theme
    adwaita-icon-theme
    material-black-colors
    themechanger
    bibata-cursors
    xdotool
    jq

    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    nerd-fonts._0xproto
    dejavu_fonts
    noto-fonts
    noto-fonts-color-emoji
    material-symbols
    google-fonts
  ];

  # Copy scripts
  home.file.".local/share/bin" = {
    source = ../../dotfiles/local/share/bin;
    recursive = true;
    executable = true;
  };

  # Copy nemo actions
  home.file.".local/share/nemo/actions" = {
    source = ../../dotfiles/local/share/nemo/actions;
    recursive = true;
  };

  # Copy configs
  xdg.configFile.fastfetch.source = ../../dotfiles/config/fastfetch;
  xdg.configFile.foot.source = ../../dotfiles/config/foot;
  xdg.configFile."gtk-3.0".source = ../../dotfiles/config/gtk-3.0;
  xdg.configFile."gtk-4.0".source = ../../dotfiles/config/gtk-4.0;
  xdg.configFile.hypr.source = ../../dotfiles/config/hypr_lua;
  xdg.configFile.rofi.source = ../../dotfiles/config/rofi;
  xdg.configFile."wofi/config".source = ../../dotfiles/config/wofi/config;
  xdg.configFile."wofi/nix_logo.png".source = ../../dotfiles/config/wofi/nix_logo.png;
  xdg.configFile."wofi/style.css".text = builtins.replaceStrings
    [ "@HOME@" ]
    [ config.home.homeDirectory ]
      (builtins.readFile ../../dotfiles/config/wofi/style.css);
  xdg.configFile."wal/templates".source = ../../dotfiles/config/wal/templates;
  xdg.configFile.waybar.source = ../../dotfiles/config/waybar;
  xdg.configFile.wlogout.source = ../../dotfiles/config/wlogout;
}
