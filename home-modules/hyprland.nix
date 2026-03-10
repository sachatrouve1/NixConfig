{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # hyprutils
    hyprland-qtutils
    # hyprland-qt-support
    hyprpicker
    hyprlock
    hypridle
    hyprsunset
    hyprcursor
    hyprshade
    # hyprlang
    # hyprgraphics
    # aquamarine
    xdg-desktop-portal-hyprland
    gvfs
    qt5.qtwayland
    qt6.qtwayland

    waybar
    rofi
    pywal
    pywalfox-native
    grim
    slurp
    wl-clipboard
    swww
    swaynotificationcenter
    wlogout
    nwg-look
    nwg-displays
    papirus-icon-theme
    adwaita-icon-theme
    gtk-engine-murrine
    material-black-colors
    themechanger
    bibata-cursors

    nerd-fonts.symbols-only
    nerd-fonts._0xproto
    dejavu_fonts
    noto-fonts
    noto-fonts-color-emoji
  ];

  xdg.configFile.fastfetch.source = ../dotfiles/.config/fastfetch;
  xdg.configFile.foot.source = ../dotfiles/.config/foot;
  xdg.configFile."gtk-3.0".source = ../dotfiles/.config/gtk-3.0;
  xdg.configFile."gtk-4.0".source = ../dotfiles/.config/gtk-4.0;
  xdg.configFile.hypr.source = ../dotfiles/.config/hypr;
  xdg.configFile.rofi.source = ../dotfiles/.config/rofi;
  xdg.configFile."wal/hooks".source = ../dotfiles/.config/wal/hooks;
  xdg.configFile."wal/templates".source = ../dotfiles/.config/wal/templates;
  xdg.configFile.waybar.source = ../dotfiles/.config/waybar;
  xdg.configFile.wlogout.source = ../dotfiles/.config/wlogout;
}
