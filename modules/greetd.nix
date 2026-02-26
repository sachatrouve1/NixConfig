{ pkgs, inputs, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
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
