{host, ...}: let
  inherit (import ../../../hosts/${host}/variables.nix) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    signing.format = null;

    settings = {
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };

      # FOSS-friendly settings
      push = {
        default = "simple"; # Match modern push behavior
        autoSetupRemote = true; # Automatically set upstream on first push
      };
      branch = {
        main = {
          remote = "origin";
          merge = "refs/heads/main";
        };
        autosetupmerge = "true"; # Set up tracking (merge) for new branches
        autosetuprebase = "never"; # Never auto-rebase when setting up tracking
      };
      credential.helper = "cache --timeout=7200";
      init.defaultBranch = "main"; # Set default new branches to 'main'
      log.decorate = "full"; # Show branch/tag info in git log
      log.date = "iso"; # ISO 8601 date format
      # Conflict resolution style for readable diffs
      merge.conflictStyle = "diff3";

      # Optional: FOSS-friendly Git aliases
      alias = {
        br = "branch --sort=-committerdate";
        co = "checkout";
        df = "diff";
        com = "commit -a";
        gs = "stash";
        gp = "pull";
        lg = "log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %C(green)(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit";
        st = "status";
      };
    };
  };
}
