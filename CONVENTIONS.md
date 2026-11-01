# ZaneyOS Project Guidelines

- Workflow: Never attempt to run system rebuilds (`fr`, `zcli rebuild`) or git push commands automatically. Provide explicit file updates and give commands for the user to execute manually.
- Git Configuration: Always use `programs.git.settings` instead of the deprecated `programs.git.extraConfig` in Home Manager modules.
