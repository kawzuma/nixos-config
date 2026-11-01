{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Use the pinned overlay so Nix locks to the exact nixpkgs revision that
  # Lan Tian's binary cache (https://cache.lantian.pub/lantian) has pre-built
  # CachyOS kernels for. This prevents compiling the kernel from source.
  # The substituter and trusted-public-key for that cache are configured
  # centrally in modules/core/system.nix.
  nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

  # mkForce so this host-level kernel package set overrides the
  # lib.mkDefault fallback in modules/core/boot.nix.
  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
}
