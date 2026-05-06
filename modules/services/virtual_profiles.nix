{ config, pkgs, ... }:

{
  specialisation = {

    android.configuration = {
      # rien à faire : KVM autorisé
      virtualisation.virtualbox.host.enable = false;
    };

    virtualbox.configuration = {

      # Désactive KVM AU NIVEAU KERNEL
      boot.blacklistedKernelModules = [
        "kvm"
        "kvm_intel"
        "kvm_amd"
      ];

      # Active VirtualBox
      virtualisation.virtualbox.host.enable = true;

      # Optionnel mais recommandé
      virtualisation.virtualbox.host.enableExtensionPack = true;
    };
  };
}
