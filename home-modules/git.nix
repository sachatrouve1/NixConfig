{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.lazygit
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "sacha.trouve0@gmail.com";
        name = "Sacha";
      };
      init.defaultBranch = "main";
    };
  };
}
