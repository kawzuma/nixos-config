{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Use the pinned overlay so Nix locks to the exact nixpkgs revision that
  # Lan Tian's binary cache (https://cache.lantian.pub/lantian) has pre-built
  # CachyOS kernels for. This prevents compiling the kernel from source.
  nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

  nix.settings = {
    # mkAfter so this host-level list appends to (rather than replaces) the
    # substituters/keys from modules/core/system.nix and modules/core/cachix.nix.
    substituters = lib.mkAfter ["https://cache.lantian.pub/lantian"];
    trusted-public-keys = lib.mkAfter ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="];
  };

  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
}
