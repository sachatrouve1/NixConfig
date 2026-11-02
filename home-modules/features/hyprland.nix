{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
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
    file.".local/hypr/bin" = {
      source = ../../dotfiles/local/hypr/bin;
      recursive = true;
      executable = true;
    };

    # Copy nemo actions
    file.".local/share/nemo/actions" = {
      source = ../../dotfiles/local/share/nemo/actions;
      recursive = true;
    };
  };

  # Copy configs
  xdg = {
    configFile = {
      fastfetch.source = ../../dotfiles/config/fastfetch;
      foot.source = ../../dotfiles/config/foot;
      "gtk-3.0".source = ../../dotfiles/config/gtk-3.0;
      "gtk-4.0".source = ../../dotfiles/config/gtk-4.0;
      hypr.source = ../../dotfiles/config/hypr_lua;
      rofi.source = ../../dotfiles/config/rofi;
      "wal/templates".source = ../../dotfiles/config/wal/templates;
      "wal/hooks".source = ../../dotfiles/config/wal/hooks;
      waybar.source = ../../dotfiles/config/waybar;
      wlogout.source = ../../dotfiles/config/wlogout;
      "wofi/config".source = ../../dotfiles/config/wofi/config;
      "wofi/nix_logo.png".source = ../../dotfiles/config/wofi/nix_logo.png;
      "wofi/style.css".text = builtins.replaceStrings [ "@HOME@" ] [ config.home.homeDirectory ] (
        builtins.readFile ../../dotfiles/config/wofi/style.css
      );
    };
  };
}
