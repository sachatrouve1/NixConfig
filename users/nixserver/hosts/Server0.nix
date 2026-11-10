{ userName, ... }:
{
  imports = [
    ../../../home-modules/base.nix
  ];

  home = {
    stateVersion = "25.11";
    username = userName;
    homeDirectory = "/home/${userName}";
  };
}
