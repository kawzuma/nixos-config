{
  config,
  lib,
  ...
}: {
  hardware.nvidia = {
    # RTX 50-series requires the open kernel module
    open = lib.mkForce true;
    # Newest NVIDIA driver nixpkgs offers (use .stable for the safer one)
    package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
