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
      # Keep the default cache.nixos.org first (the previous plain list replaced it).
      # Lan Tian's cache provides pre-built CachyOS kernel binaries; see
      # hosts/nixos/kernel.nix which pins the matching nixpkgs revision via the
      # nix-cachyos-kernel pinned overlay.
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://cache.lantian.pub/lantian"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
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
