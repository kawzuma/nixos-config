{
  inputs,
  pkgs,
  lib,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  inherit (vars) barChoice;

  # Noctalia-specific packages
  noctaliaPkgs =
    if barChoice == "noctalia"
    then
      with pkgs; [
        matugen # color palette generator needed for noctalia-shell
      ]
    else [];
in {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = false; # Firefox is not installed by default
    hyprland = {
      enable = true; # set this so desktop file is created
      withUWSM = false;
    };
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    hyprlock.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  environment.systemPackages = with pkgs;
    [
      awww
    ]
    ++ noctaliaPkgs
    ++ [
      alejandra # nix formatter
      brave-origin # default browser
      brightnessctl # For Screen Brightness Control
      eza # Fast, modern ls replacement
      ffmpeg # Terminal Video / Audio Editing
      fd # Simple, fast find replacement
      gnumake # Needed for build tools / emacs
      mpv # Video Player
      sqlite # SQLite database engine
      socat # Multipurpose relay / IPC
      unrar # Rar archive support
      unzip # Zip extraction support
      usbutils # USB Devices tools
      upower # noctalia shell battery
      v4l-utils # Video4Linux utilities
      waybar # Status bar
      waypaper # Change wallpaper
      wget # File retriever
      python3 # Python 3 runtime
      nwg-displays # Display configuration utility
    ];
}
