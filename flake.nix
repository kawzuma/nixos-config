{
  description = "ZaneyOS";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/master";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    # Now avilable in nikpkgs
    # Leaving this in case need latest build
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Checking nixvim to see if it's better
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    synfetch = {
      url = "github:SXSLVT/synfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghee = {
      url = "git+https://codeberg.org/justaguylinux/ghee.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CachyOS kernel. Do NOT add "inputs.nixpkgs.follows" here (the author says it breaks things).
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # FreeSM Launcher — Minecraft Java launcher (fork of PrismLauncher).
    # Not in nixpkgs, so pull it from its own flake. No nixpkgs.follows here:
    # if the build errors with "input 'nixpkgs' does not exist", the flake
    # doesn't declare one and we must NOT add follows.
    freesmlauncher.url = "github:FreesmTeam/FreesmLauncher";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    nix-flatpak,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "nixos";
    profile = "nvidia";
    username = "kaw";

    # Deduplicate nixosConfigurations while preserving the top-level 'profile'
    mkNixosConfig = gpuProfile:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile; # keep using the let-bound profile for modules/scripts
        };
        modules = [
          ./modules/core/overlays.nix
          ./profiles/${gpuProfile}
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
  in {
    # Lan Tian's binary cache (cache.lantian.pub/lantian) hosts pre-built CachyOS
    # kernel binaries for xddxdd/nix-cachyos-kernel. Combined with the pinned
    # overlay in hosts/nixos/kernel.nix, Nix fetches pre-built binaries instead
    # of compiling the kernel from source.
    # The FreeSM Launcher cache (freesmlauncher.cachix.org) serves pre-built
    # binaries for the `freesmlauncher` flake input, so flake-level commands
    # (nix flake lock / nix build) also avoid compiling it from source.
    nixConfig = {
      substituters = [
        "https://cache.nixos.org"
        "https://cache.lantian.pub/lantian"
        "https://freesmlauncher.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
        "freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
      ];
    };

    nixosConfigurations = {
      amd = mkNixosConfig "amd";
      nvidia = mkNixosConfig "nvidia";
      nvidia-laptop = mkNixosConfig "nvidia-laptop";
      amd-nvidia-hybrid = mkNixosConfig "amd-nvidia-hybrid";
      intel = mkNixosConfig "intel";
      vm = mkNixosConfig "vm";
    };

    formatter.x86_64-linux = inputs.alejandra.packages.x86_64-linux.default;
  };
}
