# Configuration NixOS Multi-host

Configuration NixOS + Home Manager centralisée avec Flakes.

Ce dépôt sépare la configuration en trois couches:
- la configuration système NixOS par machine,
- la configuration Home Manager partagée par utilisateur,
- les dotfiles et fichiers annexes consommés par ces modules.

Cette base permet de piloter plusieurs machines depuis un seul dépôt:
- un laptop principal (`ThinkpadT480`),
- un poste secondaire (`Fujitsu`),
- un serveur (`Server0`).

## Objectifs

- Mutualiser les briques communes (base, shell, sécurité, firewall, services).
- Activer des profils par type de machine (laptop, gaming, server, desktop).
- Garder une configuration utilisateur déclarative via Home Manager.
- Déployer une machine précise avec une seule commande `nixos-rebuild --flake`.

## Structure du dépôt

```text
.
├── flake.nix
├── dotfiles/
├── hosts/
│   ├── Fujitsu/
│   │   └── default.nix
│   ├── Server0/
│   │   └── default.nix
│   └── ThinkpadT480/
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/
│   ├── core/
│   ├── hardware/
│   ├── profiles/
│   └── services/
├── home-modules/
│   ├── base.nix
│   └── features/
│       ├── android.nix
│       ├── fish.nix
│       ├── gaming.nix
│       ├── git.nix
│       ├── hyprland.nix
│       ├── java.nix
│       ├── librewolf.nix
│       ├── udisk.nix
│       ├── zsh.nix
│       ├── lazyvim/
│       └── vscode/
└── users/
    ├── nixserver/hosts/Server0.nix
    └── sacha/hosts/
        ├── Fujitsu.nix
        └── ThinkpadT480.nix
```

## Fonctionnement global

Le fichier `flake.nix` déclare les entrées `nixpkgs` et `home-manager`, puis construit les configurations NixOS via une fonction `mkHost`.

Chaque host est assemblé en 2 couches:
1. couche système: `./hosts/<hostName>`
2. couche utilisateur: `home-manager.users.<userName> = import ./users/<userName>/hosts/<hostName>.nix`

Hosts exposés:
- `ThinkpadT480` -> utilisateur `sacha`
- `Fujitsu` -> utilisateur `sacha`
- `Server0` -> utilisateur `nixserver`

## Répartition des responsabilités

- `hosts/` contient les points d'entrée NixOS par machine et les options spécifiques à chaque matériel.
- `modules/` regroupe les briques système partagées, les profils par type de machine et les services optionnels.
- `home-modules/` contient la configuration Home Manager commune et les modules de fonctionnalités utilisateur.
- `dotfiles/` stocke les fichiers concrets consommés par les modules Home Manager, comme les configs de `hypr`, `nvim`, `waybar`, `rofi`, `kitty` ou les scripts locaux.
- `users/` relie chaque compte utilisateur à la machine correspondante et compose les modules Home Manager adéquats.
