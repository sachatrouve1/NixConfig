{ config, pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.httpd = {
    enable = true;
    enablePHP = true;

    # Utilisation de buildEnv pour configurer proprement les extensions PHP d'Apache
    phpPackage = pkgs.php.buildEnv {
      extensions =
        { enabled, all }:
        enabled
        ++ (with all; [
          curl
          mbstring
          openssl
          pdo_mysql
          zip
        ]);
    };

    virtualHosts."localhost" = {
      listen = [
        {
          ip = "*";
          port = 80;
        }
      ];
      documentRoot = "/var/www/page";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
