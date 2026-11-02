{host, ...}: let
  vars = import ../../hosts/${host}/variables.nix;
  consoleKeyMap = vars.consoleKeyMap or "us";
in {
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Keep the default cache.nixos.org first (a plain list replaces the default).
      # Lan Tian's cache provides pre-built CachyOS kernel binaries; see
      # hosts/nixos/kernel.nix which pins the matching nixpkgs revision via the
      # nix-cachyos-kernel pinned overlay.
      # FreeSM Launcher's Cachix cache serves pre-built binaries for the
      # `freesmlauncher` flake input (github:FreesmTeam/FreesmLauncher).
      #
      # IMPORTANT: plain lists only — do NOT wrap these in lib.mkAfter/lib.mkBefore.
      # This module is the only active definer of these options (cachix.nix is not
      # imported), so an order marker would never be merged away and would reach
      # the `listOf str` type check as a set, causing:
      #   error: expected a list but found a set: { _type = "order"; content = ... }
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.lantian.pub/lantian"
        "https://freesmlauncher.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
        "freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
      ];
    };
  };
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    ZANEYOS_VERSION = "2.6.5";
    ZANEYOS = "true";
  };
  console.keyMap = "${consoleKeyMap}";
  system.stateVersion = "23.11"; # Do not change!
}
