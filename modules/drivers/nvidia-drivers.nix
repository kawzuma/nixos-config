{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia;
in {
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia_drm.fbdev=1"
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      NVD_BACKEND = "direct";
    };

    hardware.nvidia = {
      # Modesetting is required for Wayland compositors.
      modesetting.enable = true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
      # Blackwell (RTX 50-series) requires open kernel modules.
      open = true;
      # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
      nvidiaSettings = true;
      # Blackwell architecture (RTX 5070) requires driver version 570+ (provided by beta/latest).
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
