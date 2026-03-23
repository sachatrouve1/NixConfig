{ config, pkgs, ... }:
{
  services.inspircd = {
    enable = true;
    config = ''
      <config format="xml">
      <define name="bindip" value="127.0.0.1">
      <define name="localips" value="&bindip;/24">

      <server
        name="clodoflare"
        description="IRC server"
        id="001"
        network="clodoflare">

      <admin
        name="Admin"
        nick="admin"
        email="admin@localhost">

      <bind
        address="&bindip;"
        port="6667"
        type="clients">

      <options
        case-mapping="ascii">

      <logging
        method="file"
        target="/var/log/inspircd/inspircd.log">

      <connect allow="*"
        host="*"
        recvq="512000"
        sendq="512000"
        timeout="90">
    '';
  };
}
