{ config, pkgs, ... }:
{
  services.tor = {
    enable = true;
    client.enable = true;
    relay.onionServices = {
      "irc" = {
        version = 3;
        map = [{
          port = 6667;
          target = {
            addr = "127.0.0.1";
            port = 6667;
          };
        }];
      };
    };
  };

  programs.proxychains = {
    enable = true;
  };
}
