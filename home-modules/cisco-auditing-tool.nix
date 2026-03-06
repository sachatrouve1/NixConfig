{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (callPackage (
      { stdenv, fetchFromGitHub, perl, perlPackages, lib }:
      stdenv.mkDerivation {
        pname = "cisco-auditing-tool";
        version = "unstable-2024";
        src = fetchFromGitHub {
          owner = "foreni-packages";
          repo = "cisco-auditing-tool";
          rev = "master";
          hash = "sha256-DYFc8/1PQNDrHv812a42GZxht2k2cC0qmt+F8WnvmZc=";
        };

        buildInputs = [
          perl
          perlPackages.NetAddrIP
          perlPackages.IOStringy
          perlPackages.NetTelnet
        ];

        postPatch = ''
          cat > plugins/brute << 'EOF'
use Net::Telnet();

sub brute {
    my ($host, $port, $password) = @_;
    
    my $telnet = Net::Telnet->new(
        Timeout => 10,
        Errmode => 'return',
        Input_Log => "/dev/null",
    );
    
    return 0 unless $telnet->open($host, $port);
    
    my $response = $telnet->waitfor('/password[: ]*$/i');
    return 0 unless defined $response;
    
    $telnet->print($password);
    
    ($prematch, $match) = $telnet->waitfor(-match => '/>$/i', -match => '/password[: ]*$/i');
    
    if (defined $match && $match =~ />$/i) {
        $telnet->close;
        return 1;
    }
    
    $telnet->close;
    return 0;
}

1;
EOF
        '';

        installPhase = ''
          mkdir -p $out/share/cisco-auditing-tool
          cp -r lib lists plugins $out/share/cisco-auditing-tool/
          cp CAT $out/share/cisco-auditing-tool/

          mkdir -p $out/bin
          cat > $out/bin/CAT << 'EOF'
#!/bin/sh
CAT_DIR="@out@/share/cisco-auditing-tool"
cd "$CAT_DIR"
exec perl "$CAT_DIR/CAT" "$@"
EOF
          substituteInPlace $out/bin/CAT --subst-var-by out $out
          chmod +x $out/bin/CAT
        '';

        meta = {
          description = "Scans Cisco routers for common vulnerabilities";
          homepage = "https://github.com/foreni-packages/cisco-auditing-tool";
          license = lib.licenses.gpl2;
          mainProgram = "CAT";
        };
      }
    ) {})
  ];
}
