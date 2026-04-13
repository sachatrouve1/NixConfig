{ pkgs, inputs, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in {
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "sacha";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --time --remember --cmd ${session}";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Redirige les erreurs vers le journal plutôt que l'écran
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
