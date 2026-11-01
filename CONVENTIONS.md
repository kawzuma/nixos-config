# ZaneyOS Project Guidelines

- Workflow: Never attempt to run system rebuilds (`fr`, `zcli rebuild`) or git push commands automatically. Provide explicit file updates and give commands for the user to execute manually.
- Git Configuration: Always use `programs.git.settings` instead of the deprecated `programs.git.extraConfig` in Home Manager modules.
- Strict Declarativeness: Every new app configuration, setting, script, or modification must be implemented as a dedicated, declarative `.nix` module rather than manual file edits or imperative workarounds.
- Kernel Caching & Overlays: Always preserve Lan Tian's binary cache (`https://cache.lantian.pub/lantian`) and the pinned CachyOS kernel overlay (`nix-cachyos-kernel.overlays.pinned`) to ensure builds pull pre-built binaries instead of compiling from source.
