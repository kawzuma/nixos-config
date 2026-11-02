{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      # Pre-built Proton from the binary cache (no source builds).
      # NOTE: pkgs.proton-cachyos is not available in the pinned nixpkgs
      # revision used with the nix-cachyos-kernel overlay, so we use
      # proton-ge-bin as the default compatibility tool.
      # For CachyOS's own proton-cachyos build, use the ProtonPlus app
      # (installed below) to download it into
      # ~/.steam/root/compatibilitytools.d/ — Steam picks it up automatically.
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };

  # ProtonPlus: GUI for managing Proton versions in Steam. Use it to install
  # the CachyOS proton-cachyos build; Steam then offers it as a compatibility
  # tool in each game's properties.
  environment.systemPackages = [pkgs.protonplus];
}
