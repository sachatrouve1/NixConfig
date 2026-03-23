{ config, pkgs, ... }:
{
  security.apparmor.enable = true;

  boot.kernel.sysctl = {
    # Prevents from seeing the kernel addresses 
    "kernel.kptr_restrict" = 1;
    # Restricts the use of dmesg to admins
    "kernel.dmesg_restrict" = 1;
    # Protection against session theft via ptrace
    "kernel.yama.ptrace_scope" = 1;
    # Improves protection against common network attacks, prevents IP spoofing
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
  };
}
