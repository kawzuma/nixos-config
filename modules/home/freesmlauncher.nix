# FreeSM Launcher — Minecraft Java launcher (fork of PrismLauncher).
# Not packaged in nixpkgs, so it comes from its own flake input
# (flake.nix: inputs.freesmlauncher = github:FreesmTeam/FreesmLauncher).
# `inputs` is passed through extraSpecialArgs from modules/core/user.nix.
{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  fsmPkgs = inputs.freesmlauncher.packages.${system};
  # The flake may expose the launcher as `freesmlauncher` or only as `default`;
  # the `or` fallback covers both. If neither exists, the build error will
  # list the available attribute names.
  freesmLauncher = fsmPkgs.freesmlauncher or fsmPkgs.default;
in {
  home.packages = [
    freesmLauncher
  ];
}
