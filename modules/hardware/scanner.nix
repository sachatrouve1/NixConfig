{
  config,
  pkgs,
  userName,
  ...
}:

{
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-backends ];
  };

  users.users.${userName} = {
    extraGroups = [
      "scanner"
      "lp"
    ];
  };

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
