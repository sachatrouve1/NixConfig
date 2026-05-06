{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.smartcardDev;
in
{
  options.services.smartcardDev = {
    enable = mkEnableOption "Smart card / NFC development environment";

    enableJavaCard = mkOption {
      type = types.bool;
      default = false;
      description = "Enable JavaCard development tools";
    };

    user = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "User to add to smartcard-related groups";
    };
  };

  config = mkIf cfg.enable {

    #### PC/SC daemon
    services.pcscd.enable = true;

    #### Udev rules for NFC readers
    services.udev.packages = [
      pkgs.libnfc
      pkgs.pcsclite
    ];

    #### System packages
    environment.systemPackages =
      with pkgs; [
        pcsc-tools
        opensc
        libnfc
        gnupg
        yubikey-manager
      ]
      ++ lib.optionals cfg.enableJavaCard (with pkgs; [
        ant
        maven
        global-platform-pro
        openjdk17
      ]);

    #### Optional user permissions
    users.users = mkIf (cfg.user != null) {
      "${cfg.user}".extraGroups = [
        "pcscd"
        "plugdev"
      ];
    };

    #### Useful defaults
    environment.variables = {
      PCSCLITE_CSOCK_NAME = "/run/pcscd/pcscd.comm";
    };

    #### Documentation hint
    warnings = [
      "SmartcardDev enabled: card contents are read-only unless you own the keys."
    ];
  };
}
