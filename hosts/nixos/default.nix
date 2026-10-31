{...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
    ./kernel.nix
    ./nvidia.nix
  ];
}
