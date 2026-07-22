{ pkgs, config, ... }:

{
  services.bentopdf = {
    enable = true;
    # Configures the Nginx virtual host domain
    domain = "bento.pdf.com";
    nginx.enable = true;
  };

  # Optional: map bento.pdf.com to 127.0.0.1 locally so it works in browser
  networking.extraHosts = ''
    127.0.0.1 bento.pdf.com
  '';
}

