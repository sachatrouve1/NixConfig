{ config, pkgs, ... }:

{
  services.thinkfan = {
    enable = true;

    settings = {
      sensors = [
        {
          chip = "thinkpad-isa-0000";
          ids = [ "CPU" "temp3" "temp4" "temp5" "temp6" "temp7" "temp8" ];
        }
      ];

      fans = [
        {
          tpacpi = "/proc/acpi/ibm/fan";
        }
      ];

      levels = [
        [ 0  0 49 ]
        [ 1 49 54 ]
        [ 2 54 59 ]
        [ 3 59 64 ]
        [ 4 64 69 ]
        [ 5 69 74 ]
        [ 6 74 79 ]
        [ 7 79 89 ]
        [ "level disengaged" 89 32767 ]
      ];
    };
  };
}
