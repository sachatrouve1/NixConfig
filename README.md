# Configuration NixOS Multi-host

Configuration NixOS + Home Manager centralisée avec Flakes.

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
├── hosts/
│   ├── ThinkpadT480/
│   ├── Fujitsu/
│   └── Server0/
├── modules/
│   ├── core/
│   ├── hardware/
│   ├── profiles/
│   └── services/
└── users/
    ├── base.nix
    ├── features/
    ├── sacha/hosts/
    └── nixserver/hosts/
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
