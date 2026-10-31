{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

  nix.settings = {
    substituters = ["https://cache.lantian.pub/lantian"];
    trusted-public-keys = ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="];
  };

  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
}
