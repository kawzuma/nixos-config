{
  inputs,
  pkgs,
  lib,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  inherit (vars) barChoice;

  # Local build of synfetch (github:SXSLVT/synfetch).
  #
  # The upstream flake's package reads the deprecated `pkgs.stdenv.isLinux`
  # attribute, so pulling in `inputs.synfetch.packages.<system>.default` makes
  # every evaluation of this configuration print:
  #   evaluation warning: stdenv.isLinux is deprecated, use stdenv.hostPlatform.isLinux instead
  #
  # Rebuilding the same writeShellApplication here, using the script from the
  # input, keeps the tool and drops the warning. Remove this and go back to
  # `inputs.synfetch.packages.<system>.default` once upstream is fixed.
  synfetch = pkgs.writeShellApplication {
    name = "synfetch";
    runtimeInputs =
      with pkgs;
      [
        coreutils
        ncurses
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
        pciutils
        procps
      ];
    checkPhase = "";
    text = builtins.readFile "${inputs.synfetch}/synfetch";
  };
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
      synfetch
    ]
    ++ noctaliaPkgs
    ++ [
      alejandra # nix formatter
      amfora # Terminal Browser For Gemini Protocol
      brightnessctl # For Screen Brightness Control
      cliphist # Clipboard manager using rofi menu
      docker-compose # Allows Controlling Docker From A Single File
      duf # Utility For Viewing Disk Usage In Terminal
      eza # Fast, modern ls replacement
      ffmpeg # Terminal Video / Audio Editing
      file-roller # Archive Manager
      fd # Simple, fast find replacement
      gnumake # Needed for build tools / emacs
      google-chrome # default browser
      gpu-screen-recorder # needed for noctalia-shell
      power-profiles-daemon # needed for noctalia-shell power cycle
      mesa-demos # needed for inxi diag util
      tuigreet # Display Manager
      htop # Terminal System Monitor
      eog # Image Viewer
      inxi # CLI System Information Tool
      killall # Kill processes by name
      libnotify # Desktop notifications
      lm_sensors # Hardware Temps
      lshw # Detailed Hardware Information
      mdcat # CLI markdown parser
      mpv # Video Player
      ncdu # Disk Usage Analyzer With Ncurses Interface
      nwg-displays # Configure monitor configs via GUI
      pavucontrol # Audio Levels & Devices GUI
      pciutils # Inspection of PCI Devices
      pkg-config # Package compiler helper
      playerctl # Media Volume and playback control
      ripgrep # Fast grep replacement
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
    ];
}
