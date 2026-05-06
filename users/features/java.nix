{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    jdk17
    maven
    gradle
  ];

  home.sessionVariables = {
    JAVA_8_HOME = "${pkgs.jdk8}/lib/openjdk";
    JAVA_17_HOME = "${pkgs.jdk17}/lib/openjdk";
    JAVA_25_HOME = "${pkgs.jdk25}/lib/openjdk";
    JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
  };
}
