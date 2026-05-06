{ config, userName, ...  }:
{
  users.users.${userName}.extraGroups = [
    "docker"
  ];
  virtualisation.docker.enable = true;
}
